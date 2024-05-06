# frozen_string_literal: true

module ApplicationHelper
  def link_to_card(card, &blk)
    link_to(
      controller: 'card',
      action: 'show',
      set: card.set_code,
      id: card.number,
      # This part is purely decorative, so we don't bother testing it
      name: card.name
                .gsub("'s", 's')
                .gsub("I'm", 'Im')
                .gsub("You're", 'youre')
                .gsub('R&D', 'RnD')
                .gsub(/[^a-zA-Z0-9\-]+/, '-')
                .gsub(/(\A-)|(-\z)/, ''),
      &blk
    )
  end

  def link_to_card_name(card_name, &blk)
    link_to(
      controller: 'card',
      action: 'index',
      q: "!#{card_name}",
      &blk
    )
  end

  def link_to_set(set, &blk)
    link_to(controller: 'set', action: 'show', id: set.code, &blk)
  end

  def link_to_deck(deck, &blk)
    link_to(controller: 'deck', action: 'show', set: deck.set_code, id: deck.slug, &blk)
  end

  def download_link_to_deck(deck, *html_options, &blk)
    link_to({ controller: 'deck', action: 'download', set: deck.set_code, id: deck.slug }, *html_options, &blk)
  end

  def link_to_artist(artist, &blk)
    link_to(controller: 'artist', action: 'show', id: artist.slug, &blk)
  end

  def link_to_search(search, &blk)
    link_to(controller: 'card', action: 'index', q: search, &blk)
  end

  def format_oracle_text(card_text)
    h(card_text || '')
      .gsub(/\A\n+/, '')
      .gsub(Card::ABILITY_WORD_RX) do |_m|
        "<i class='ability_word'>#{Regexp.last_match(1)}</i> —"
      end
      .gsub("\n", '<br/>')
      .gsub(/(?:\{.*?\})+/) do
        "<span class=\"manacost\">#{format_mana_symbols(Regexp.last_match(0))}</span>"
      end
      .gsub(/s*\([^()]*\)/) do
        "<i class='reminder_text'>#{Regexp.last_match(0)}</i>"
      end
      .gsub(/\[([+\-\u2013\u2212]?(?:\d+|N|X))\]/) do
        symbol = Regexp.last_match(1)
        usymbol = symbol.sub('-', "\u2013").sub("\u2212", "\u2013")
        dir = case usymbol[0]
              when '+'
                'up'
              when "\u2013"
                'down'
              else
                'zero'
              end

        %(<i class="mana mana-loyalty mana-loyalty-#{dir}" data-loyalty="#{usymbol}"></i>) +
          %(<span class="sr-only">[#{usymbol}]</span>)
    end
      .html_safe
  end

  def card_picture_path(card)
    ApplicationHelper.card_picture_path(card)
  end

  def card_picture_path_hq(card)
    ApplicationHelper.card_picture_path_hq(card)
  end

  def card_picture_path_lq(card)
    ApplicationHelper.card_picture_path_lq(card)
  end

  def card_gallery_path(card)
    first_printing = card.printings.first
    "/card/gallery/#{first_printing.set_code}/#{first_printing.number}"
  end

  def printings_view(selected_printing, matching_printings)
    matching_printings = matching_printings.to_set
    selected_printing
      .printings
      .sort_by { |cp| [cp.release_date, cp] }
      .map do |cp|
        if cp == selected_printing
          [:selected, cp]
        elsif matching_printings.include?(cp)
          [:matching, cp]
        else
          [:not_matching, cp]
        end
      end
      .group_by { |_type, cp| cp.set_name }
      .to_a
      .reverse
  end

  def printings_view_full(selected_printing, matching_printings)
    matching_printings = matching_printings.to_set
    selected_printing
      .printings
      .sort_by { |cp| [cp.release_date, cp] }
      .map do |cp|
        if cp == selected_printing
          [:selected, cp]
        elsif matching_printings.include?(cp)
          [:matching, cp]
        else
          [:not_matching, cp]
        end
      end
      .group_by { |_type, cp| [cp.set_name, cp.rarity] }
      .to_a
      .reverse
  end

  def self.card_picture_path(card)
    if card.layout != 'split'
      url_hq = "https://mse-modern.com/msem2/images/#{card.set_code}/#{card.number}.jpg"
      url_lq = "https://mse-modern.com/msem2/images//#{card.set_code}/#{card.number}.jpg"
    else
      tempNumber = card.number.gsub(/[ab]/, '')
      url_hq = "https://mse-modern.com/msem2/images//#{card.set_code}/#{tempNumber}.jpg"
      url_lq = "https://mse-modern.com/msem2/images//#{card.set_code}/#{tempNumber}.jpg"
    end
    return url_hq if url_hq.present?
    return url_lq if url_lq.present?

    nil
  end

  def self.card_picture_path_hq(card)
    url_hq = "/cards_hq/#{card.set_code}/#{card.number}.jpg"
    path_hq = Pathname(__dir__) + "../../public#{url_hq}"
    return url_hq if path_hq.exist?

    nil
  end

  def self.card_picture_path_lq(card)
    url_lq = "/cards/#{card.set_code}/#{card.number}.jpg"
    path_lq = Pathname(__dir__) + "../../public#{url_lq}"
    return url_lq if path_lq.exist?

    nil
  end

  private

  def format_mana_symbols(syms)
    syms.gsub(/\{(.*?)\}/) do
      sym  = Regexp.last_match(0).upcase
      mana = Regexp.last_match(1).gsub('/', '').downcase
      if good_mana_symbols.include?(mana)
        if mana[0] == 'h'
          %(<span class="mana mana-half"><span class="mana mana-cost mana-#{mana[1..]}"><span class="sr-only">#{sym}</span></span></span>)
        elsif (mana == 'p') || (mana == 'chaos') || (mana == 'pw') || (mana == 'e')
          %(<span class="mana mana-#{mana}"><span class="sr-only">#{sym}</span></span>)
        else
          %(<span class="mana mana-cost mana-#{mana}"><span class="sr-only">#{sym}</span></span>)
        end
      else
        sym
      end
    end.html_safe
  end

  def good_mana_symbols
    @good_mana_symbols ||= Set[
      'x', 'y', 'z',
      '0', '1', '2', '3', '4', '5', '6', '7', '8', '9',
      '10', '11', '12', '13', '14', '15', '16', '17', '18', '19', '20',
      'w', 'u', 'b', 'r', 'g',
      'wu', 'wb', 'rw', 'gw', 'ub', 'ur', 'gu', 'br', 'bg', 'rg',
      '2w', '2u', '2b', '2r', '2g',
      'wp', 'up', 'bp', 'rp', 'gp', 'p',
      's', 'q', 't', 'c', 'e',
      '½', '1000000', '100', '∞',
      'chaos', 'pw',
      'hw', 'hr',
      'v'
    ]
  end

  def language_name(language_code)
    {
      cs: 'Simplified Chinese',
      ct: 'Traditional Chinese',
      fr: 'French',
      de: 'German',
      it: 'Italian',
      jp: 'Japanese',
      kr: 'Korean',
      pt: 'Brazilian Portuguese',
      ru: 'Russian',
      sp: 'Spanish'
    }.fetch(language_code)
  end

  def language_flag(language_code)
    {
      cs: 'cn',
      ct: 'tw',
      fr: 'fr',
      de: 'de',
      it: 'it',
      jp: 'jp',
      kr: 'kr',
      pt: 'br',
      ru: 'ru',
      sp: 'es'
    }.fetch(language_code)
  end

  def preview_id(card)
    [card.set_code, card.number, card.foil ? 'foil' : nil].compact.join('-')
  end

  def is_champion_printing?(card)
    card.prints_champion != ""
  end
end

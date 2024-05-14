# frozen_string_literal: true

# This class represents card from index point of view, not from data point of view
# (thinking in solr/lucene terms)
require 'date'
require_relative 'ban_list'
require_relative 'legality_information'

class Card
  ABILITY_WORD_LIST = ['Adamant','Addendum','Alliance','Battalion','Bloodrush','Celebration','Channel','Chroma','Cohort',
                       'Constellation','Converge','Council’s dilemma','Coven','Delirium','Descend 4','Descend 8','Domain',
                       'Eminence','Enrage','Fateful hour','Fathomless descent','Ferocious','Formidable','Grandeur','Hellbent',
                       'Heroic','Imprint','Inspired','Join forces','Kinship','Landfall','Lieutenant','Magecraft','Metalcraft',
                       'Morbid','Pack tactics','Paradox','Parley','Radiance','Raid','Rally','Revolt','Secret council',
                       'Spell mastery','Strive','Sweep','Tempting offer','Threshold','Undergrowth','Will of the council',
                       'Adorned','Armed','Art of war','Augmented','Bulwark','Beakthrough','Civilized','Concord','Dominance','Duet','Foresee',
                       'Foresight','Glorious end','Identity','Machinate','Menagerie','Prismatic','Rapport','Resolute','Sabotage','Stampede',
                       'Vanguard','Wanderlust','Wildcast'].freeze
  ABILITY_WORD_RX = /^(#{Regexp.union(ABILITY_WORD_LIST)}) —/i.freeze

  attr_accessor :printings
  attr_reader :data, :name, :names, :layout, :colors, :mana_cost, :reserved, :types, :changes, :full_oracle, :otags,
              :partial_color_identity, :cmc, :text, :text_normalized, :power, :toughness, :loyalty, :extra, :hand,
              :life, :rulings, :foreign_names, :foreign_names_normalized, :stemmed_name, :mana_hash, :typeline, :funny, 
              :color_indicator, :related, :reminder_text, :augment, :display_power, :display_toughness, :display_mana_cost

  # For db subset

  def initialize(data)
    @printings = []
    @name = data['name']
    @stemmed_name = normalize_name(@name).downcase.gsub(/s\b/, '').tr('-', ' ')
    @names = data['names']
    @layout = data['layout']
    @changes = data['changes'] || ''
    @colors = data['colors'] || ''
    @funny = data['funny']
    @full_oracle = (data['text'] || '')
    @full_oracle = -@full_oracle.sub(/\s*\z/, '').gsub(/ *\n/, "\n").sub(/\A\s*/, '')
    @text = (data['text'] || '')
    @text = @text.gsub(/\s*\([^()]*\)/, '') unless @funny
    @text = -@text.sub(/\s*\z/, '').gsub(/ *\n/, "\n").sub(/\A\s*/, '')
    @text_normalized = -@text.gsub('Æ', 'Ae').tr("Äàáâäèéêíõöúûu’\u2212", "Aaaaaeeeioouuu'-")
    @augment = !(@text =~ /augment \{/i).nil?
    @mana_cost = data['manaCost']
    @reserved = data['reserved'] || false
    @types = %w[types subtypes supertypes]
             .flat_map { |t| data[t] || [] }
             .map { |t| -t.downcase.tr("’\u2212", "'-").gsub("'s", '').tr(' ', '-') }
    @cmc = data['cmc'] || 0
    @power = data['power'] ? smart_convert_powtou(data['power']) : nil
    @toughness = data['toughness'] ? smart_convert_powtou(data['toughness']) : nil
    @loyalty = data['loyalty'] ? smart_convert_powtou(data['loyalty']) : nil
	@otags = data['otags'] || []
    @display_power = data['display_power'] || @power
    @display_toughness = data['display_toughness'] || @toughness
    @display_mana_cost = data['hide_mana_cost'] ? nil : @mana_cost
    @partial_color_identity = calculate_partial_color_identity
    @extra = if %w[vanguard plane scheme phenomenon].include?(@layout) || @types.include?('conspiracy')
               true
             else
               false
             end
    @hand = data['hand']
    @life = data['life']
    @rulings = data['rulings']
    @secondary = data['secondary']
    @foreign_names = if data['foreign_names']
                       data['foreign_names'].transform_keys(&:to_sym)
                     else
                       {}
                     end
    @foreign_names_normalized = {}
    @foreign_names.each do |lang, names|
      @foreign_names_normalized[lang] = names.map { |n| hard_normalize(n) }
    end
    @related = data['related']
    @typeline = [data['supertypes'], data['types']].compact.flatten.join(' ')
    @typeline += " - #{data['subtypes'].join(' ')}" if data['subtypes']
    @typeline = -@typeline
    calculate_mana_hash
    calculate_color_indicator
    calculate_reminder_text
  end

  def front?
    !@secondary or @layout == 'aftermath' or @layout == 'flip' or @layout == 'adventure'
  end

  def back?
    !front?
  end

  def primary?
    !@secondary
  end

  def secondary?
    @secondary
  end

  attr_writer :color_identity

  def color_identity
    @color_identity ||= begin
      return partial_color_identity unless @names

      raise 'Multi-part cards need to have CI set by database'
    end
  end

  def has_multiple_parts?
    !!@names
  end

  def inspect
    "Card(#{name})"
  end

  include Comparable
  def <=>(other)
    name <=> other.name
  end

  def to_s
    inspect
  end

  def legality_information(date = nil)
    LegalityInformation.new(self, date)
  end

  def first_release_date
    @first_release_date ||= @printings.map(&:release_date).compact.min
  end

  def first_regular_release_date
    @first_regular_release_date ||= @printings
                                    .reject { |cp| cp.set_code == 'ptc' }
                                    .map(&:release_date)
                                    .compact
                                    .min
  end

  def last_release_date
    @last_release_date ||= @printings.map(&:release_date).compact.max
  end

  private

  def calculate_mana_hash
    if @mana_cost.nil?
      @mana_hash = nil
      return
    end
    @mana_hash = Hash.new(0)

    mana = @mana_cost.gsub(/\{(.*?)\}/) do
      m = Regexp.last_match(1)
      case m
      when /\A\d+\z/
        @mana_hash['?'] += m.to_i
      when /\A[wubrgxyzc]\z/
        # x is basically a color for this kind of queries
        @mana_hash[m] += 1
      when /\Ah([wubrg])\z/
        @mana_hash[Regexp.last_match(1)] += 0.5
      when %r{\A([wubrg])/([wubrg])\z}
        @mana_hash[normalize_mana_symbol(m)] += 1
      when %r{\A([wubrg])/p\z}
        @mana_hash[normalize_mana_symbol(m)] += 1
      when %r{\A2/([wubrg])\z}
        @mana_hash[normalize_mana_symbol(m)] += 1
      when %r{\A([v][p])\z}
        @mana_hash[normalize_mana_symbol(m)] += 1
      else
        raise "Unrecognized mana type: #{m}"
      end
      ''
    end
    raise "Mana query parse error: #{mana}" unless mana.empty?
  end

  def normalize_mana_symbol(sym)
    -sym.downcase.tr('/{}', '').chars.sort.join
  end

  def normalize_name(name)
    -name.gsub('Æ', 'Ae').tr('Äàáâäèéêíõöúûu', 'Aaaaaeeeioouuu')
  end

  def hard_normalize(s)
    -UnicodeUtils.downcase(UnicodeUtils.nfd(s).gsub(/\p{Mn}/, ''))
  end

  def smart_convert_powtou(val)
    return val unless val.is_a?(String)
    # Treat augment "+1"/"-1" strings as regular 1/-1 numbers for search engine
    # The view can use special format for them
    return val.to_i if val =~ /\A\+\d+\z/

    if val !~ /\A-?[\d.]+\z/
      # It just so happens that "2+*" > "1+*" > "*" asciibetically
      # so we don't do any extra conversions,
      # but we might need to setup some eventually
      #
      # Including uncards
      # "*" < "*²" < "1+*" < "2+*"
      # but let's not get anywhere near that
      case val
      when '*', '*²', '1+*', '2+*', '7-*', 'X', '∞', '?', '*+1', '*+2'
        val
      else
        raise "Unrecognized value #{val.inspect}"
      end
    elsif val.to_i == val.to_f
      val.to_i
    else
      val.to_f
    end
  end

  def calculate_partial_color_identity
    ci = colors.chars
    "#{mana_cost} #{text}".scan(/{(.*?)}/).each do |sym,|
      case sym.downcase
      when /\A(\d+|[½∞txyzsqpce])\z/
        # 12xyz - colorless
        # ½∞ - unset colorless
        # t - tap
        # q - untap
        # s - snow
        # p - generic Phyrexian mana (like on Rage Extractor text)
        # c - colorless mana
      when /\A([wubrg])\z/
        ci << Regexp.last_match(1)
      when 'mg'
        # don't do anything
      when %r{\A([wubrg])/p\z}
        # Phyrexian mana
        ci << Regexp.last_match(1)
      when /\Ah([wubrg])\z/
        # Unset half colored mana
        ci << Regexp.last_match(1)
      when %r{\A2/([wubrg])\z}
        ci << Regexp.last_match(1)
      when %r{\A([wubrg])/([wubrg])\z}
        ci << Regexp.last_match(1) << Regexp.last_match(2)
      when 'chaos'
        # planechase special symbol, disregard
      when %r{\A(vp|flag|mag)\z}
        # noncolor symbols, disregard
      else
        raise "Unknown mana symbol `#{sym}'"
      end
    end
    types.each do |t|
      tci = { 'forest' => 'g', 'mountain' => 'r', 'plains' => 'w', 'island' => 'u', 'swamp' => 'b' }[t]
      ci << tci if tci
    end
    -ci.sort.uniq.join
  end

  def calculate_color_indicator
    colors_inferred_from_mana_cost = (@mana_hash || {}).keys
                                                       .flat_map do |x|
      next [] if x =~ /[?xyzcv]/

      x = x.sub(/[p2]/, '')
      if x =~ /\A[wubrg]+\z/
        x.chars
      else
        raise "Unknown mana cost: #{x}"
      end
    end

    actual_colors = @colors.chars

    @color_indicator = if colors_inferred_from_mana_cost.sort == actual_colors.sort
                         nil
                       else
                         color_indicator_name(actual_colors)
                       end
  end

  def color_indicator_name(indicator)
    names = { 'w' => 'white', 'u' => 'blue', 'b' => 'black', 'r' => 'red', 'g' => 'green' }
    color_indicator = names.map { |c, cv| indicator.include?(c) ? cv : nil }.compact
    case color_indicator.size
    when 5
      'all colors'
    when 1, 2
      color_indicator.join(' and ')
    when 3
      # Nicol Bolas from M19
      a, b, c = color_indicator
      "#{a}, #{b}, and #{c}"
    when 0
      # devoid and Ghostfire - for some reason they use rules text, not color indicator
      # "colorless"
      nil
    else # find phrasing for 3/4 colors
      raise
    end
  end

  def calculate_reminder_text
    @reminder_text = nil
    basic_land_types = (%w[forest island mountain plains swamp] & @types.to_a)
                       .sort.join(' ')
    if !basic_land_types.empty?
      # Listing them all explicitly due to wubrg wheel order
      mana = case basic_land_types
             when 'plains'
               '{W}'
             when 'island'
               '{U}'
             when 'swamp'
               '{B}'
             when 'mountain'
               '{R}'
             when 'forest'
               '{G}'
             when 'island plains'
               '{W} or {U}'
             when 'plains swamp'
               '{W} or {B}'
             when 'island swamp'
               '{U} or {B}'
             when 'island mountain'
               '{U} or {R}'
             when 'mountain swamp'
               '{B} or {R}'
             when 'forest swamp'
               '{B} or {G}'
             when 'forest mountain'
               '{R} or {G}'
             when 'mountain plains'
               '{R} or {W}'
             when 'forest plains'
               '{G} or {W}'
             when 'forest island'
               '{G} or {U}'
             when 'forest plains swamp'
               '{W}, {B}, or {G}'
             when 'forest island mountain'
               '{G}, {U}, or {R}'
             when 'island mountain plains'
               '{U}, {R}, or {W}'
             when 'mountain plains swamp'
               '{R}, {W}, or {B}'
             when 'forest island swamp'
               '{B}, {G}, or {U}'
             when 'island plains swamp'
               '{W}, {U}, or {B}'
             when 'island mountain swamp'
               '{U}, {B}, or {R}'
             when 'forest mountain swamp'
               '{B}, {R}, or {G}'
             when 'forest mountain plains'
               '{R}, {G}, or {W}'
             when 'forest island plains'
               '{G}, {W}, or {U}'
             else
               raise "No idea what's correct line for #{basic_land_types.inspect}"
             end
      @reminder_text = "({T}: Add #{mana}.)"
    elsif (layout == 'flip') && secondary?
      # Awkward wording
      other_name = (@names - [@name])[0]
      @reminder_text = "(#{@name} keeps color and mana cost of #{other_name} when flipped)"
    end
  end
  
end

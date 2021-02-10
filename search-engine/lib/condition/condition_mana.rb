# frozen_string_literal: true

class ConditionMana < ConditionSimple
  def initialize(op, mana)
    @op = op
    @query_mana = parse_query_mana(mana.downcase)
    @needs_resolution = !!(@query_mana.keys.join =~ /[mnoh]/)
  end

  def match?(card)
    card_mana = card.mana_hash
    if @query_mana.empty?
      case @op
      when '='
        !card_mana
      when '!='
        !card_mana.nil?
      when '>', '>=', '<', '<='
        # This is all nonsense
        false
      else
        raise "Unrecognized comparison #{@op}"
      end
    else
      return @op == '!=' unless card_mana

      q_mana = if @needs_resolution
                 resolve_variable_mana(card_mana, @query_mana)
               else
                 @query_mana
               end
      cmps = (card_mana.keys | q_mana.keys).map { |color| [card_mana[color], q_mana[color]] }
      case @op
      when '>='
        cmps.all? { |a, b| a >= b }
      when '>'
        cmps.all? { |a, b| a >= b } and !cmps.all? { |a, b| a == b }
      when '='
        cmps.all? { |a, b| a == b }
      when '!='
        cmps.any? { |a, b| a != b }
      when '<'
        cmps.all? { |a, b| a <= b } and !cmps.all? { |a, b| a == b }
      when '<='
        cmps.all? { |a, b| a <= b }
      else
        raise "Unrecognized comparison #{@op}"
      end
    end
  end

  def to_s
    "mana#{@op}#{query_mana_to_s}"
  end

  private

  def query_mana_to_s
    res = []
    @query_mana.each do |m, c|
      c = c.to_i if c == c.to_i
      case m
      when '?'
        res << c.to_s
      else
        mx = if m =~ /\A[wubrgc]\z/
               m
             else
               "{#{m}}"
             end
        if c.is_a?(Integer)
          c.times { res << mx }
        elsif c % 1 == 0.5
          c.floor.times { res << mx }
          res << "{h#{m}}"
        else
          # TOTALLY BOGUS
          res << "{#{m}=#{c}}"
        end
      end
    end
    res.sort.join
  end

  def parse_query_mana(mana)
    pool = Hash.new(0)
    mana = mana.gsub(/\{(.*?)\}|(\d+)|([wubrgxyzchmno])/) do
      if Regexp.last_match(1)
        m = Regexp.last_match(1).downcase.tr('/{}', '')
        if m =~ /\A\d+\z/
          pool['?'] += m.to_i
        elsif m == 'h'
          pool[m] += 1
        elsif m =~ /h/
          pool[m.sub('h', '').chars.sort.join] += 0.5
        elsif m != ''
          pool[m.chars.sort.join] += 1
        end
      elsif Regexp.last_match(2)
        pool['?'] += Regexp.last_match(2).to_i
      elsif Regexp.last_match(3)
        pool[Regexp.last_match(3)] += 1
      end
      ''
    end
    raise "Mana query parse error: #{mana}" unless mana.empty?

    pool
  end

  def resolve_variable_mana(card_mana, query_mana)
    card_mana = card_mana.sort_by { |key, value| [value, key] }.to_h
    query_mana = query_mana.sort_by { |key, value| [value, key] }.to_h
    q_mana = Hash.new(0)
    colors = %w[w u b r g c]
    hybrids = %w[uw bu br gr gw bw bg gu ru rw]

    query_mana.each do |color, count|
      case color
      when 'm', 'n', 'o'
        matched = false
        card_mana.each do |card_color, _card_count|
          next unless colors.include?(card_color) &&
                      !q_mana.keys.include?(card_color) &&
                      !query_mana.keys.include?(card_color)

          q_mana[card_color] = count
          matched = true
          break
        end
        q_mana[color] = count unless matched
      when 'h'
        matched = false
        card_mana.each do |card_color, _card_count|
          next unless hybrids.include?(card_color) &&
                      !q_mana.keys.include?(card_color) &&
                      !query_mana.keys.include?(card_color)

          q_mana[card_color] = count
          matched = true
          break
        end
        q_mana[color] = count unless matched
      else
        q_mana[color] = count
      end
    end
    q_mana
  end

  def normalize_mana_symbol(sym)
    sym.downcase.tr('/{}', '').chars.sort.join
  end
end

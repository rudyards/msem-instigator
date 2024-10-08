# frozen_string_literal: true

require 'damerau-levenshtein'

class SpellingSuggestions
  def initialize
    @words = Set[]
    @words2 = Set[]
  end

  def <<(text)
    words_in_title = normalize_text(text).scan(/\w+/)
    words_in_title.each do |word|
      @words << normalize_text(word) if word.size >= 2
    end
    words_in_title.each_cons(2) do |w1, w2|
      @words2 << normalize_text("#{w1} #{w2}") if (w1.size >= 2) && (w2.size >= 2)
    end
  end

  def suggest(query)
    # If "Rancor" is already in DB, do not suggest "Ranger" no matter what
    return [] if @words.include?(query)

    query = normalize_text(query)
    return [] if @words.include?(query)

    max_distance = if query.size <= 2
                     0
                   elsif query.size <= 4
                     1
                   else
                     2
                   end

    results_multipart = []
    # Try only words at least 2 characters
    # There are silly things like en-Dal
    (2..query.size - 2).each do |i|
      a = query[0...i]
      b = query[i..]
      results_multipart << "#{a} #{b}" if @words2.include?("#{a} #{b}")
    end

    return results_multipart.sort unless results_multipart.empty?

    results_typo = (0...max_distance).map { [] }
    @words.each do |word|
      d = DamerauLevenshtein.distance(word, query)
      results_typo[d - 1] << word if d <= max_distance
    end

    results_typo.each do |r|
      return r.sort unless r.empty?
    end

    []
  end

  private

  def normalize_text(text)
    text.downcase.gsub(/[Ææ]/, 'ae').tr("Äàáâäèéêíõöúûu’\u2212", "Aaaaaeeeioouuu'-").gsub(/'s\b/, '').strip
  end
end

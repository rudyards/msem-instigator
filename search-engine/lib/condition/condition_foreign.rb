# frozen_string_literal: true

require 'unicode_utils'
class ConditionForeign < ConditionSimple
  def initialize(lang, query)
    @lang = lang.downcase
    # Support both Gatherer and MCI naming conventions
    @lang = 'ct' if @lang == 'tw'
    @lang = 'cs' if @lang == 'cn'
    @query = hard_normalize(query)
    # For CJK match anywhere
    # For others match only word boundary
    case @query
    when '*'
      # OK
    when /\p{Han}|\p{Katakana}|\p{Hiragana}|\p{Hangul}/
      @query_regexp = Regexp.new("(?:#{Regexp.escape(@query)})", Regexp::IGNORECASE)
    else
      @query_regexp = Regexp.new("\\b(?:#{Regexp.escape(@query)})\\b", Regexp::IGNORECASE)
    end
  end

  def match?(card)
    foreign_names = if @lang == 'foreign'
                      card.foreign_names_normalized.values.flatten
                    else
                      card.foreign_names_normalized[@lang.to_sym] || []
                    end
    if @query == '*'
      !foreign_names.empty?
    else
      foreign_names.any? do |n|
        n =~ @query_regexp
      end
    end
  end

  def to_s
    "#{@lang}:#{maybe_quote(@query)}"
  end

  private

  def hard_normalize(s)
    UnicodeUtils.downcase(UnicodeUtils.nfd(s).gsub(/\p{Mn}/, ''))
  end
end

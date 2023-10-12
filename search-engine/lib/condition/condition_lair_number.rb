# frozen_string_literal: true

class ConditionLairNumber < ConditionSimple
    def initialize(lairNumber, op = ':')
      @number_s = lairNumber.downcase
      @number_i = @number_s.to_i
      @op = op
    end
  
    def match?(card)
      return unless card.respond_to?(:lairnumber)

      card_number_s = card.lairnumber&.downcase || nil
      card_number_i = card.lairnumber&.to_i || nil
      case @op
      when '>'
        ([card_number_i, card_number_s] <=> [@number_i, @number_s]).positive?
      when '>='
        ([card_number_i, card_number_s] <=> [@number_i, @number_s]) >= 0
      when '<'
        ([card_number_i, card_number_s] <=> [@number_i, @number_s]).negative?
      when '<='
        ([card_number_i, card_number_s] <=> [@number_i, @number_s]) <= 0
      else # = or :
        card_number_s == @number_s
      end
    end
  
    def to_s
      "lairNumber#{@op}#{maybe_quote(@number_s)}"
    end
end
  
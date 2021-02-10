# frozen_string_literal: true

class ConditionIsBrawler < ConditionSimple
  def match?(card)
    return false if card.secondary?
    if card.types.include?('legendary') && (card.types.include?('creature') || card.types.include?('planeswalker'))
      return true
    end

    false
  end

  def to_s
    'is:brawler'
  end
end

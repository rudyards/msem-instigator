# frozen_string_literal: true

class ConditionChampion < ConditionSimple
  def initialize(champion)
    @champion = champion
  end

  def match?(card)
    return false unless card.prints_champion&.downcase.include?(@champion)
    return true
  end

  def to_s
    "champion:#{maybe_quote(@champion)}"
  end
end

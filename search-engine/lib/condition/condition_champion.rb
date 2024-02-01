# frozen_string_literal: true

class ConditionChampion < ConditionSimple
  def initialize(champion)
    @champion = champion.downcase
  end

  def match?(card)
    card.card.champion&.downcase.include?(@champion)
  end

  def to_s
    "champion:#{maybe_quote(@champion)}"
  end
end

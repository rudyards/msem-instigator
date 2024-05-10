# frozen_string_literal: true

class ConditionIsChampion < ConditionSimple
  def match?(card)
    return false unless card.champion&.downcase.present?
    return true
  end

  def to_s
    'is:champion'
  end
end

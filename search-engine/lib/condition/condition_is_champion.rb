# frozen_string_literal: true

class ConditionIsChampion < ConditionSimple
  def match?(card)
    return false unless card.champion&.downcase.present?
    return true if ["MPS_MSE", "CHAMPIONS"].include?(card.set_code)

    return true if card.set_code == "LAIR" && ["99", "119"].include?(card.lairnumber)

    return false
  end

  def to_s
    'is:champion'
  end
end

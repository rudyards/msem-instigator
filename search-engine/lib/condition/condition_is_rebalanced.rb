# frozen_string_literal: true

class ConditionIsRebalanced < ConditionSimple
  def match?(card)
    return true if (card.card.otags & ["reworked", "nerfed", "buffed"]).any?
	return false
  end

  def to_s
    'is:rebalanced'
  end
end

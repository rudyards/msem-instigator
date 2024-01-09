# frozen_string_literal: true

class ConditionIsRebalanced < ConditionSimple
  def match?(card)
    card.changes.blank? == false
  end

  def to_s
    'is:rebalanced'
  end
end

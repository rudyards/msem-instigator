# frozen_string_literal: true

class ConditionIsChanged < ConditionSimple
  def match?(card)
    card.changes.blank? == false
  end

  def to_s
    'is:changed'
  end
end

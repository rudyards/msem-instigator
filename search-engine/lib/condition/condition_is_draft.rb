# frozen_string_literal: true

class ConditionIsDraft < ConditionSimple
  def match?(card)
    return true if card.types.include?('conspiracy')
    return true if card.text.include?('as you draft it')
    return true if card.text.include?('you drafted')
    return true if card.text.include?('draft') && card.text.include?('face up')

    false
  end

  def to_s
    'is:draft'
  end
end

# frozen_string_literal: true

class ConditionPrintTag < ConditionSimple
  def initialize(tag)
    @tag = tag
  end

  def match?(card)
    return false unless card.atags.include?(@tag)
    return true
  end

  def to_s
    "atag:#{maybe_quote(@tag)}"
  end
end

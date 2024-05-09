# frozen_string_literal: true

class ConditionCardTag < ConditionSimple
  def initialize(tag)
    @tag = tag
  end

  def match?(card)
    return false unless card.card.otags.include?(@tag)
    return true
  end

  def to_s
    "otag:#{maybe_quote(@tag)}"
  end
end

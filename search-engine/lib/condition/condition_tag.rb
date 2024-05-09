# frozen_string_literal: true

class ConditionAnyTag < ConditionSimple
  def initialize(tag)
    @tag = tag
  end

  def match?(card)
    if card.atags.include?(@tag) || card.card.otags.include?(@tag)
      return true
	else
      return false
	end
  end

  def to_s
    "tag:#{maybe_quote(@tag)}"
  end
end

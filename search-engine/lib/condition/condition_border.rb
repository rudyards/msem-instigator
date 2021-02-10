# frozen_string_literal: true

class ConditionBorder < ConditionSimple
  def initialize(border)
    @border = border.downcase
  end

  def match?(card)
    card.border == @border
  end

  def to_s
    "is:#{@border}-bordered"
  end
end

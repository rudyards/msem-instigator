# frozen_string_literal: true

class ConditionDesigner < ConditionSimple
  def initialize(designer)
    @designer = designer.downcase
  end

  def match?(card)
    card.card.designer.downcase.include?(@designer)
  end

  def to_s
    "designer:#{maybe_quote(@designer)}"
  end
end

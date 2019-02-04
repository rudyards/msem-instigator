class ConditionDesigner < ConditionSimple
  def initialize(designer)
    @designer = designer.downcase
  end

  def match?(card)
    card.designer_name.downcase.include?(@designer)
  end

  def to_s
    "a:#{maybe_quote(@designer)}"
  end
end

class ConditionDesignerRegexp < ConditionRegexp
  def match?(card)
    card.designer_name =~ @regexp
  end

  def to_s
    "a:#{@regexp.inspect.sub(/i\z/, "")}"
  end
end

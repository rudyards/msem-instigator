class ConditionDesignerRegexp < ConditionRegexp
  def match?(card)
    card.designer =~ @regexp
  end
  
  def to_s
    "designer:#{@regexp.inspect.sub(/i\z/, "")}"
  end
end
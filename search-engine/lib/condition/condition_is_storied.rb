class ConditionIsStoried < ConditionSimple
  def match?(card)
    card_types = card.types
    ["legendary", "enchantment"].any? do |type|
      card_types.include?(type)
    end
  end

  def to_s
    "is:storied"
  end
end

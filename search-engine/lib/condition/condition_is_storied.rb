# frozen_string_literal: true

class ConditionIsStoried < ConditionSimple
  def match?(card)
    card_types = card.types
    %w[legendary enchantment].any? do |type|
      card_types.include?(type)
    end
  end

  def to_s
    'is:storied'
  end
end

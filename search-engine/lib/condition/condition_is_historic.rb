# frozen_string_literal: true

class ConditionIsHistoric < ConditionSimple
  def match?(card)
    card_types = card.types
    %w[legendary artifact saga].any? do |type|
      card_types.include?(type)
    end
  end

  def to_s
    'is:historic'
  end
end

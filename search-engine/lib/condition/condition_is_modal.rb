# frozen_string_literal: true

class ConditionIsModal < ConditionSimple
  def match?(card)
    card_types = card.types
    %w[instant sorcery].any? do |type|
      return true if card.text.include?('•') && card_types.include?(type)
    end
  end

  def to_s
    'is:modal'
  end
end

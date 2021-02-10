# frozen_string_literal: true

class ConditionIsPermanent < ConditionSimple
  def match?(card)
    card.types.none? do |t|
      %w[instant sorcery plane scheme phenomenon conspiracy vanguard].include?(t)
    end
  end

  def to_s
    'is:permanent'
  end
end

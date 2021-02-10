# frozen_string_literal: true

class ConditionIsCommander < ConditionSimple
  def match?(card)
    return false if card.secondary?
    return true if card.types.include?('legendary') && card.types.include?('creature')
    return true if card.text =~ /\bcan be your commander\b/

    false
  end

  def to_s
    'is:commander'
  end
end

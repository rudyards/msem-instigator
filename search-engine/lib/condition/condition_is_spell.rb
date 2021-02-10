# frozen_string_literal: true

class ConditionIsSpell < ConditionSimple
  def match?(card)
    card.types.all? { |t| t != 'land' }
  end

  def to_s
    'is:spell'
  end
end

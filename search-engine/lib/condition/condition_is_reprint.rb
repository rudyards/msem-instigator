# frozen_string_literal: true

class ConditionIsReprint < ConditionSimple
  def match?(card)
    card.age.positive?
  end

  def to_s
    'is:reprint'
  end
end

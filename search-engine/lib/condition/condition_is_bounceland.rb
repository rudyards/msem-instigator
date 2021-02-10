# frozen_string_literal: true

class ConditionIsBounceland < Condition
  def search(db)
    names = [
      'sprawling coast',
      'shaded cove',
      'scorched sanctum',
      'distant highlands',
      'suntouched temple',
      'boundless sinks',
      'crystal coasts',
      'lonely morass',
      'endless deserts',
      'unexplored ruins'
    ]

    names
      .map { |n| db.cards[n] }
      .flat_map { |card| card ? card.printings : [] }
      .to_set
  end

  def to_s
    'is:bounceland'
  end
end

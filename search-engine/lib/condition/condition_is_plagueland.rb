# frozen_string_literal: true

class ConditionIsPlagueland < Condition
  def search(db)
    names = [
      'arctic mine', 'crumbling precipice', 'crystal cavern', 'forgotten steppe', 'murmuring falls',
      "nomad's township", 'rampant summit', 'resplendent substratum', 'sedate tundra', 'shifting glade'
    ]

    names
      .map { |n| db.cards[n] }
      .flat_map { |card| card ? card.printings : [] }
      .to_set
  end

  def to_s
    'is:plagueland'
  end
end

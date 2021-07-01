# frozen_string_literal: true

class ConditionIsCycleland < Condition
  def search(db)
    names = [
        "boiling ridge",
        "duskwood thicket",
        "hazy moorland",
        "rugged fields",
        "sungrace meadows",
        "bustling harbor",
        "dreary township",
        "glittering grove",
        "monsoon lagoon",
        "urban wastelands",
    ]

    names
      .map { |n| db.cards[n] }
      .flat_map { |card| card ? card.printings : [] }
      .to_set
  end

  def to_s
    'is:cycleland'
  end
end

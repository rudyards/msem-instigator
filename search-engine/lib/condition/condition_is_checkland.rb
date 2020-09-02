class ConditionIsCheckland < Condition
  def search(db)
    names = [
      "lush oasis","spiraling canyon","fungal mire",
      "frostfire geysers","gloomcover steppe","heart of the glade",
      "flourishing crevasse","lavatorn fields","flooded morass","pool of light",
    ]

    names
      .map{|n| db.cards[n]}
      .flat_map{|card| card ? card.printings : []}
      .to_set
  end

  def to_s
    "is:checkland"
  end
end

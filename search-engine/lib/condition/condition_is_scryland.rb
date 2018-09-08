class ConditionIsScryland < Condition
  def search(db)
    names = [
      "Winterheath Pass",
      "Chillroad Pass",
      "Stonework Gate Pass",
      "Hanatun Pass",
      "Sunset Grove Pass",
      "Ravenwood Pass",
      "Sky's Reach Pass",
      "Grimrot Pass",
      "Glory Bridge Pass",
      "Frozen Wilds Pass",
    ]

    names
      .map{|n| db.cards[n]}
      .flat_map{|card| card ? card.printings : []}
      .to_set
  end

  def to_s
    "is:scryland"
  end
end

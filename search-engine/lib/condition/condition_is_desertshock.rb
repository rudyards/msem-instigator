class ConditionIsDesertshock< Condition
  def search(db)
    names = [
      "weathered oasis","scorched canyon","sunset sands",
      "mountain spring","lonely dunes","sunlit cactus",
      "clay mesa","hostile dunes","arid ruins","canyon falls",
    ]

    names
      .map{|n| db.cards[n]}
      .flat_map{|card| card ? card.printings : []}
      .to_set
  end

  def to_s
    "is:desertshock"
  end
end

class ConditionIsScryland < Condition
  def search(db)
    names = [
      "frozen wilds pass","glory bridge pass","grimrot pass",
      "sky's reach pass","ravenwood pass","sunset grove pass",
      "hanatun pass","stonework gate pass","chillroad pass",
      "winterheath pass"
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

class ConditionIsCycleland < Condition
  def search(db)
    names = [
      "back alley","expansive sprawl","lakeside market","rugged outcropping","weathered slums",
      "courtroom halls","empty courtyard","ornate interior","torchlit shipyard","waterway dam"
    ]

    names
      .map{|n| db.cards[n]}
      .flat_map{|card| card ? card.printings : []}
      .to_set
  end

  def to_s
    "is:cycleland"
  end
end
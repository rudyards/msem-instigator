class ConditionIsDrawdual < Condition
  def search(db)
    names = [
      "ashen slab","coastal cliffs","fetid sinkhole","forgotten alcove","murky isle",
      "overgrown jungle","silent mire","sweeping mesa","undergrowth forest","windy valley"
    ]

    names
      .map{|n| db.cards[n]}
      .flat_map{|card| card ? card.printings : []}
      .to_set
  end

  def to_s
    "is:drawdual"
  end
end
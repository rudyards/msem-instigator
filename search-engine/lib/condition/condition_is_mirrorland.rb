class ConditionIsMirrorland < Condition
  def search(db)
    names = [
      "crafted coast","dire dive","haunted estate","lush outcrop",
      "spired canopy","ghastly castle","grisly marsh","sunken cavern","sunny dunes"
    ]

    names
      .map{|n| db.cards[n]}
      .flat_map{|card| card ? card.printings : []}
      .to_set
  end

  def to_s
    "is:mirrorland"
  end
end
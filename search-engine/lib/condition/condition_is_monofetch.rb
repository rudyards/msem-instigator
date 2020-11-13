class ConditionIsMonofetch < Condition
  def search(db)
    names = [
      "gleaming river","murky peat","sunwashed spires","tropical grove","vast savannah"
    ]

    names
      .map{|n| db.cards[n]}
      .flat_map{|card| card ? card.printings : []}
      .to_set
  end

  def to_s
    "is:monofetch"
  end
end
class ConditionIsInvestigateland < Condition
  def search(db)
    names = [
      "backstage rooms","heist headquarters","hidden hollow","legitimate establishment","seedy bar",
      "cleared vault","forgotten shrine","grim slums","overgrown refuge","unlit alley"
    ]

    names
      .map{|n| db.cards[n]}
      .flat_map{|card| card ? card.printings : []}
      .to_set
  end

  def to_s
    "is:investigateland"
  end
end
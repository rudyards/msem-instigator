class ConditionIsShockfetch < Condition
  def search(db)
    names = [
      "Ocean Monastery",
      "Flooded Depths",
      "Shardstone Rift",
      "Amber Hills",
      "Barren Desolation",
      "Timber Range",
      "Grim Bastion",
      "Magmatic Torrent",
      "Sunlit Highland",
      "Mysterious Cataract",
    ]

    names
      .map{|n| db.cards[n]}
      .flat_map{|card| card ? card.printings : []}
      .to_set
  end

  def to_s
    "is:shockfetch"
  end
end

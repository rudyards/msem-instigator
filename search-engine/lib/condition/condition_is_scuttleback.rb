class ConditionIsScuttleback < ConditionSimple
  def match?(card)
    return true if card.types.include?("crab")
    return true if card.types.include?("fish")
    return true if card.types.include?("jellyfish")
    return true if card.types.include?("kraken")
    return true if card.types.include?("leviathan")
    return true if card.types.include?("merfolk")
    return true if card.types.include?("nautilus")
    return true if card.types.include?("octopus")
    return true if card.types.include?("oyster")
    return true if card.types.include?("pirate")
    return true if card.types.include?("seal")
    return true if card.types.include?("serpent")
    return true if card.types.include?("sponge")
    return true if card.types.include?("squid")
    return true if card.types.include?("starfish")
    return true if card.types.include?("trilobite")
    return true if card.types.include?("turtle")
    return true if card.types.include?("whale")
    return true if card.types.include?("island")
    false
  end

  def to_s
    "is:scuttleback"
  end
end

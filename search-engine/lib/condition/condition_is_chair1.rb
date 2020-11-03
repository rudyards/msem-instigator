class ConditionIsFirstSeat < ConditionSimple
  def match?(card)
    printings = card.printings
    ["GHQ","MIS","MAC","EAU","ORP"].any? do |printing|
        printings.include?(printing)
    end
  end

  def to_s
    "is:firstseat"
  end
end

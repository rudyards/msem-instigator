class ConditionIsTangoland < Condition
	def search(db)
		names = [
			"still waters",
			"muggy mire",
			"ruined shrine",
			"practice range",
			"wandering hamlet",
			"deserted steppe",
			"gnarled henge",
			"mossy shrine",
			"secluded cascade",
			"torrid geysers",
]

		names
			.map{|n| db.cards[n]}
			.flat_map{|card| card ? card.printings : []}
			.to_set
	end

	def to_s
		"is:tangoland"
	end
end
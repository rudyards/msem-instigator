class ConditionIsMeicodex < Condition
	def search(db)
		names = [
			"unraveling",
			"unrelenting",
			"mindrip",
			"swipe secrets",
]

		names
			.map{|n| db.cards[n]}
			.flat_map{|card| card ? card.printings : []}
			.to_set
	end

	def to_s
		'is:meicodex'
	end
end
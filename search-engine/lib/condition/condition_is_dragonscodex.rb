class ConditionIsDragonscodex < Condition
	def search(db)
		names = [
			"aspiring dragon",
			"scrappy hatchling",
			"skiviar scraplord",
			"blizzard dragon",
			"cloud swine",
			"gold retriever",
			"ilieth, transcendent",
]

		names
			.map{|n| db.cards[n]}
			.flat_map{|card| card ? card.printings : []}
			.to_set
	end

	def to_s
		'is:dragonscodex'
	end
end
class ConditionIsReyhsiacodex < Condition
	def search(db)
		names = [
			"ser wayver, the broken hour",
			"suzume oshiruko",
			"aguri, shadow of doubt",
			"sukhar, consort to the dark",
			"chi lee of the underworld",
]

		names
			.map{|n| db.cards[n]}
			.flat_map{|card| card ? card.printings : []}
			.to_set
	end

	def to_s
		'is:reyhsiacodex'
	end
end
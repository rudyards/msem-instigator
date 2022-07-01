class ConditionIsMoribundcodex < Condition
	def search(db)
		names = [
			"out-of-body experience",
			"event horizon",
			"strike from the shadows",
			"second death",
			"anguished unmaking",
]

		names
			.map{|n| db.cards[n]}
			.flat_map{|card| card ? card.printings : []}
			.to_set
	end

	def to_s
		'is:moribundcodex'
	end
end
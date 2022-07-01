class ConditionIsForgottencodex < Condition
	def search(db)
		names = [
			"majestic dominion",
			"pristine dominion",
			"verdant dominion",
			"stalwart dominion",
			"primal dominion",
			"rugged dominion",
			"into the woods",
]

		names
			.map{|n| db.cards[n]}
			.flat_map{|card| card ? card.printings : []}
			.to_set
	end

	def to_s
		'is:forgottencodex'
	end
end
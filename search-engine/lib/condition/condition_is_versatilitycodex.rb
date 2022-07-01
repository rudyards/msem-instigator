class ConditionIsVersatilitycodex < Condition
	def search(db)
		names = [
			"heraldry",
			"whimsy",
			"villainy",
			"creativity",
			"brutality",
]

		names
			.map{|n| db.cards[n]}
			.flat_map{|card| card ? card.printings : []}
			.to_set
	end

	def to_s
		'is:versatilitycodex'
	end
end
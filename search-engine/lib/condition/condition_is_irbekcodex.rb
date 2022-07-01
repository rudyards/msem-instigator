class ConditionIsIrbekcodex < Condition
	def search(db)
		names = [
			"little pig",
			"charging cassowary",
			"the lonely hunter",
			"shadowlurk",
			"blood constrictor",
]

		names
			.map{|n| db.cards[n]}
			.flat_map{|card| card ? card.printings : []}
			.to_set
	end

	def to_s
		'is:irbekcodex'
	end
end
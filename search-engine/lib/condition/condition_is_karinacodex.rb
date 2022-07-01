class ConditionIsKarinacodex < Condition
	def search(db)
		names = [
			"hannah, aethertechnician",
			"flynn skara",
			"pidge, tinkering courier",
			"reyhsia, truth chaser",
]

		names
			.map{|n| db.cards[n]}
			.flat_map{|card| card ? card.printings : []}
			.to_set
	end

	def to_s
		'is:karinacodex'
	end
end
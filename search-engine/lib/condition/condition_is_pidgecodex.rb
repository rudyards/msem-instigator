class ConditionIsPidgecodex < Condition
	def search(db)
		names = [
			"eleventh hour breakthrough",
			"mentorb",
			"ostracizer orb",
			"possibility engine",
			"sealed riftway",
			"self replication",
]

		names
			.map{|n| db.cards[n]}
			.flat_map{|card| card ? card.printings : []}
			.to_set
	end

	def to_s
		'is:pidgecodex'
	end
end
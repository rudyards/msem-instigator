class ConditionIsFamilycodex < Condition
	def search(db)
		names = [
			"fox of the orange orchard",
			"sludge-gill fox",
			"thundermane fox",
			"firemane fox",
			"sun-eyed fox",
			"moon-rune fox",
			"leafcrowned fox",
			"icecrowned fox",
			"fae-frill fox",
]

		names
			.map{|n| db.cards[n]}
			.flat_map{|card| card ? card.printings : []}
			.to_set
	end

	def to_s
		'is:familycodex'
	end
end
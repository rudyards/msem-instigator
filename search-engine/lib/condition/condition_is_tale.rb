class ConditionIsTale < Condition
	def search(db)
		names = [
			"aether sculptor",
			"boneyard mantis",
			"cave eel",
			"chitterrax",
			"darkwing wretch",
			"elken grovetender",
			"fierce combatant",
			"flatboat artisan",
			"fume whisperer",
			"gharial bandit",
			"hemophage parasite",
			"jowly recruit",
			"ox of blood bend",
			"pakka, the shadowcloak",
			"prodigious panya",
			"ruinous naga",
			"sheltered diviner",
			"student of the scroll",
			"virtuorangutan",
			"wise farseer chini",
			"prodigious panya",
			"prodigious panya",
			"pakka, the shadowcloak",
			"flatboat artisan",
			"ruinous naga",
			"prodigious panya",
			"enraptured countess",
			"daisite pioneer",
			"marianne, the heartstopper",
			"enraptured countess",
]

		names
			.map{|n| db.cards[n]}
			.flat_map{|card| card ? card.printings : []}
			.to_set
	end

	def to_s
		'is:tale'
	end
end
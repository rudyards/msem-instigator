class ConditionIsStaple < Condition
	def search(db)
		names = [
			"wayfarer's shrine",
			"nebula of empty gold",
			"seal the tomb",
			"scorch",
			"magmatic torrent",
			"event horizon",
			"cosmic sinkhole",
			"stolen secrets",
			"shardstone rift",
			"shifting glade",
			"crystal cavern",
			"stand unassailable",
			"murmuring falls",
			"mysterious cataract",
			"flooded depths",
			"sedate tundra",
			"grim bastion",
			"crumbling precipice",
			"spell pierce",
			"sunlit highland",
			"ocean monastery",
			"flooded morass",
			"duress",
			"portal fracture",
			"prying inquiry",
			"corpsebed",
			"timber range",
			"cursory glance",
			"amber hills",
			"pool of light",
			"lumbering hillock",
			"arctic mine",
			"out-of-body experience",
			"lush oasis",
			"shal'draen's rage",
			"fungal mire",
			"forgotten steppe",
			"lavatorn fields",
			"shikai's redoubt",
			"frostfire geysers",
			"the high prairies",
			"mana confluence",
			"roggar's frenzy",
			"gloomcover steppe",
			"thought blossom",
			"cane dancer",
			"embodied soul",
			"sacrificial bull",
			"still the pandemonium",
			"sealed riftway",
			"pay up",
			"voidflare",
			"forked pillar",
			"rousing rubble",
			"monkeyshines",
			"rift splicing",
			"ostracizer orb",
			"solar flare",
			"nature's claim",
			"suitor of the sea",
			"rampant summit",
			"recall forgotten eons",
			"idyllic odyssey",
			"end of all things",
			"reveal eternities",
			"garth of the chimera",
			"bounty of the gardens",
			"banished companion",
			"admonish",
			"fractured reach",
			"spiraling canyon",
			"sigil of radiance",
			"tiny heroine totti",
			"seek prophecy",
			"negate",
			"prodigious panya",
			"nereba, sandchoked archives",
			"corrupted memory",
			"shugenja sanctuary",
			"northern express line",
			"dreamsight well",
			"inishtu, desert healer",
			"basat charm",
			"rage of the ravaged",
			"conjure realities",
			"hugo of the shadowstaff",
			"mystery of the crashed craft",
			"bant command",
			"stormsurge",
			"caulte axeslinger",
			"singularity's grasp",
			"grim slums",
			"hierarch ranger",
			"powder scatterer",
			"aerie's pillar",
			"gaze deeper",
			"antimagic",
			"wheat from chaff",
			"polyp pools",
			"mana ascetic",
			"mirrorgate",
			"new divide",
			"ria-demian charm",
			"lumenbay flyer line",
			"flaming point technique",
			"long forgotten",
			"dovon, verdant experimenter",
			"crystal conjuration",
			"fiery burst",
			"aiel tazan",
			"veilborn meddler",
			"ancestral council",
			"verdant dominion",
			"rakkiri dissident",
			"cradle of corruption",
			"unjust sentence",
			"unceasing flames",
			"profane emissary",
			"forbidden treasure",
			"masahita, bloodtongue",
			"seto san, the dragonblade",
			"shifting grove",
			"terraformer's globe",
			"once abandoned",
			"flourishing crevasse",
			"shifting cascade",
			"brutal blow",
			"heart of zhedina",
			"fox of the orange orchard",
			"nacatl skirmisher",
			"rot",
			"seismic colossus",
			"lord rickard dawson",
			"volatile stonework",
			"leyran alpha",
			"oracle's vision",
			"the flames approach",
			"ruin delver",
			"tether of simplicity",
			"union rail strikebreaker",
			"self replication",
			"shifting canyon",
			"fiery erasure",
			"emissary of antiquity",
			"sights beyond",
			"warded tome",
			"neutralize",
			"one with the world",
			"jobiah, devoted farmer",
			"ninhasir's march",
			"lt. daisy saxon",
			"stalked healer",
			"thunder road",
			"tidehollow lich",
			"xirix, the usurper",
			"roggar's gambit",
			"fierce combatant",
			"coralight champion",
			"destructive ambition",
			"waxing angel",
			"kaur, end of lies",
			"rapacious rattler",
			"silent hypnotist",
			"monsoon lagoon",
			"path of fire",
			"gift of the phoenix",
			"tamiyo, lunar arcanist",
			"sunken ambitions",
]

		names
			.map{|n| db.cards[n]}
			.flat_map{|card| card ? card.printings : []}
			.to_set
	end

	def to_s
		"is:staple"
	end
end
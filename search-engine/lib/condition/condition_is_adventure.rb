# frozen_string_literal: true

class ConditionIsTale < Condition
  def search(db)
    names = [
		"valdez, leafdown vagabond",
		"daisite pioneer",
		"adventurer extraordinaire",
		"dawn hill bellringer",
		"safety expert",
		"wayfaring mentor",
		"tinyvale finch-corps",
		"nimblefoot",
		"tongue twister",
		"siltbottom friendfinder",
		"galetwister mage",
		"highpoint guru",
		"slipsand ritualist",
		"no-good gunpointer",
		"gloomhollow scalesage",
		"conchport crook",
		"scoundreleo",
		"leafdown sizzlemage",
		"fang den flunky",
		"wimbledon's herald",
		"kula's disciple",
		"fang den bouncer",
		"paw valley pathfinder",
		"mouseketeer",
		"tinyvale treetops",
		"bleakrealm moor",
		"dawn hill outskirts",
		"flamingo rock",
		"frondpond grotto",
		"gloomhollow woodlock",
		"highpoint shrine",
		"fang den jaws",
		"slipsand oasis",
		"burning hart",
		"fennek farstrider",
		"cobri, slipsand scoundrel",
		"gruff, karoa's right paw",
		"acolyte of azos",
		"scourge of the slipsands",
		"dawn hill patriots",
		"salty dog",
		"hoof cliff caretaker",
		"toxic miscreant",
		"frondpond errand-runner",
		"strict tutor",
		"leafdown hunk",
		"dawn hill forgemaster",
		"northrime aurora",
		"valdez, leafdown vagabond",
		"highpoint hymncaller",
		"swiftspear ambusher",
		"wrathful meditant",
		"siltbottom conductor",
		"valdez's strike leader",
		"paleolizard",
		"northrime privateers",
		"hoof cliff roughrider",
		"paw valley wildclaw",
		"sturdy oakclimber",
		"shifty fink",
		"aurora weaver",
		"sunwatcher aspirant",
		"blessed suncrusher",
		"fang den headhunter",
		"whiskered buccaneer",
		"sir roger wimbledon",
		"sentinel's pike",
		"critters' companion",
		"mikkino, realized greatness",
		"panya of lands unknown",
    ]

    names
      .map { |n| db.cards[n] }
      .flat_map { |card| card ? card.printings : [] }
      .to_set
  end

  def to_s
    'is:tale'
  end
end

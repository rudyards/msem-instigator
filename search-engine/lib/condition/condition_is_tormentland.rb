# frozen_string_literal: true

class ConditionIsTormentland < Condition
  def search(db)
    names = [
      'frozen hinterlands', 'hazy coppice', 'spires of caulte', 'sunlit fissure', 'towering boughs',
      'dawnlit battlefield', 'deadwood grove', 'lush outskirts', 'shrouded rooftops', 'weathered fortress'
    ]

    names
      .map { |n| db.cards[n] }
      .flat_map { |card| card ? card.printings : [] }
      .to_set
  end

  def to_s
    'is:tormentland'
  end
end

# frozen_string_literal: true

class ConditionIsTricheck < Condition
  def search(db)
    names = [
      'bleak shoreline', 'charred marsh', 'cloudcover heights', 'forbidding isle',
      'idyllic oasis', 'deeplife cavern', 'frigid highlands', 'gleaming hot springs',
      'calmed battleground', 'sunlit ruins'
    ]

    names
      .map { |n| db.cards[n] }
      .flat_map { |card| card ? card.printings : [] }
      .to_set
  end

  def to_s
    'is:tricheck'
  end
end

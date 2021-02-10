# frozen_string_literal: true

class Sealed
  def initialize(db, *pack_descriptors)
    factory = PackFactory.new(db)
    @packs = []
    pack_descriptors.each do |descriptor|
      if descriptor =~ /\A(\d+)x(.*)/
        count = Regexp.last_match(1).to_i
        set_code = Regexp.last_match(2)
      else
        count = 1
        set_code = descriptor
      end
      pack = factory.for(set_code)
      raise "No pack for set #{set_code}" unless pack

      @packs << [count, pack]
    end
  end

  def call
    cards = []
    @packs.each do |count, pack|
      count.times do
        cards.push(*pack.open)
      end
    end
    cards
  end
end

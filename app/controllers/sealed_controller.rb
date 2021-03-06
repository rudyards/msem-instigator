# frozen_string_literal: true

class SealedController < ApplicationController
  # Controller supports >3 pack types
  def index
    counts = params[:count].to_a.map(&:to_i)
    set_codes = params[:set].to_a

    @packs_to_open = set_codes.zip(counts)
    packs_requested = !@packs_to_open.empty?
    @packs_to_open << ['dom', 6] if @packs_to_open.empty?
    @packs_to_open << [nil, 0] while @packs_to_open.size < 3

    @sets = $CardDatabase.sets_with_packs

    if packs_requested
      @cards = []
      factory = PackFactory.new($CardDatabase)
      @packs_to_open.each do |set_code, count|
        next unless set_code && count && count.positive?

        pack = factory.for(set_code) or next
        # Error handling ?
        @cards.push(*count.times.flat_map { pack.open })
      end
      @cards.sort_by! do |c|
        [
          -c.main_front.rarity_code,
          c.name,
          c.set_code,
          c.number.to_i,
          c.number,
          c.foil ? 0 : 1
        ]
      end
    end

    @title = 'Sealed'
  end
end

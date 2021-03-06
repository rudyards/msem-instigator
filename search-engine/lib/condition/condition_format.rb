# frozen_string_literal: true

require_relative '../format/format'

class ConditionFormat < Condition
  def initialize(format_name)
    @format_name = format_name.downcase.gsub(/\s|-|_/, '')
  end

  def search(db)
    @format = Format[@format_name].new(db.resolve_time(@time))
    # This is just performance hack - Standard/Modern can use this hack
    # Legacy/Vintage/Commander/etc. don't want it
    cards_probably_in_format = if @format.included_sets
                                 @format.included_sets.flat_map do |set_code|
                                   # This will only be nil in subset of db, so really only in tests
                                   set = db.sets[set_code]
                                   set ? set.printings.map(&:card) : []
                                 end.to_set
                               else
                                 db.cards.values
                               end
    cards_probably_in_format.select do |card|
      legality_ok?(@format.legality(card))
    end.flat_map(&:printings).to_set
  end

  def metadata!(key, value)
    super
    @time = value if key == :time
  end

  def to_s
    timify_to_s "f:#{maybe_quote(@format_name)}"
  end

  private

  def legality_ok?(legality)
    %w[legal restricted].include?(legality)
  end
end

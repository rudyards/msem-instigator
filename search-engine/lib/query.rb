# frozen_string_literal: true

require_relative 'query_parser'
require_relative 'search_results'
require_relative 'sorter'
require 'digest'

class Date
  # Any kind of key for sorting
  def to_i_sort
    to_time.to_i
  end
end

class Query
  attr_reader :warnings, :seed

  def initialize(query_string, seed = nil)
    @query_string = query_string
    @cond, @metadata, @warnings = QueryParser.new.parse(query_string)
    @seed = (seed || '%016x' % rand(0x1_0000_0000_0000_0000) if needs_seed?)
    @sorter = Sorter.new(@metadata[:sort], @seed)
    @warnings += @sorter.warnings
  end

  def needs_seed?
    @metadata[:sort] && @metadata[:sort] =~ /\brand\b/
  end

  def search(db)
    logger = Set[*@warnings]
    if @cond
      @cond.metadata! :logger, logger
      @cond.metadata! :fuzzy, nil
      results = @cond.search(db)
      if results.empty?
        @cond.metadata! :fuzzy, db
        results = @cond.search(db)
      end
    else
      results = db.printings
    end

    SearchResults.new(@sorter.sort(results), logger, ungrouped?)
  end

  def to_s
    str = [
      @cond.to_s,
      # ("time:#{maybe_quote(@metadata[:time])}" if @metadata[:time]),
      ("sort:#{@metadata[:sort]}" if @metadata[:sort])
    ].compact.join(' ')
    (@metadata[:ungrouped] ? "++#{str}" : str)
  end

  def ==(other)
    # structural equality, subclass if you need something fancier
    # We ignore @query_string and @seed, so queries that == won't necessarily have same random order
    # It's something we might want to revisit someday
    self.class == other.class and
      instance_variables == other.instance_variables and
      instance_variables.all?  do |ivar|
        ivar == :@query_string or
          ivar == :@seed or
          instance_variable_get(ivar) == other.instance_variable_get(ivar)
      end
  end

  def view
    @metadata[:view]
  end

  private

  def ungrouped?
    !!@metadata[:ungrouped]
  end

  def maybe_quote(text)
    case text
    when Date
      format('"%d.%d.%d"', text.year, text.month, text.day)
    when /\A[a-zA-Z0-9]+\z/
      text
    else
      text.inspect
    end
  end
end

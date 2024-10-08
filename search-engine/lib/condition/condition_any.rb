# frozen_string_literal: true

class ConditionAny < ConditionOr
  def initialize(query)
    @query = query.downcase
    @conds = [
      ConditionWord.new(query),
      ConditionArtist.new(query),
      ConditionFlavor.new(query),
      ConditionOracle.new(query),
      ConditionTypes.new(query),
      ConditionForeign.new('foreign', query)
    ]
    case @query
    when 'white'
      @conds << ConditionColorExpr.new('c', '>=', 'w')
    when 'blue'
      @conds << ConditionColorExpr.new('c', '>=', 'u')
    when 'black'
      @conds << ConditionColorExpr.new('c', '>=', 'b')
    when 'red'
      @conds << ConditionColorExpr.new('c', '>=', 'r')
    when 'green'
      @conds << ConditionColorExpr.new('c', '>=', 'g')
    when 'colorless'
      @conds << ConditionColorExpr.new('c', '=', '')
    when 'common', 'uncommon', 'rare', 'mythic', 'mythic rare', 'special', 'basic'
      @conds << ConditionRarity.new('=', @query)
    when %r{\A(-?\d+)/(-?\d+)\z}
      @conds << ConditionAnd.new(
        ConditionExpr.new('pow', '=', Regexp.last_match(1)),
        ConditionExpr.new('tou', '=', Regexp.last_match(2))
      )
    when 'augment'
      @conds << ConditionIsAugment.new
    when 'battleland'
      @conds << ConditionIsBattleland.new
    when 'bounceland'
      @conds << ConditionIsBounceland.new
    when 'checkland'
      @conds << ConditionIsCheckland.new
    when 'commander' # ???
      @conds << ConditionIsCommander.new
    when 'digital'
      @conds << ConditionIsDigital.new
    when 'dual'
      @conds << ConditionIsDual.new
    when 'draft'
      @conds << ConditionIsDraft.new
    when 'fastland'
      @conds << ConditionIsFastland.new
    when 'fetchland'
      @conds << ConditionIsFetchland.new
    when 'filterland'
      @conds << ConditionIsFilterland.new
    when 'funny'
      @conds << ConditionIsFunny.new
    when 'gainland'
      @conds << ConditionIsGainland.new
    when 'manland'
      @conds << ConditionIsManland.new
    when 'multipart'
      @conds << ConditionIsMultipart.new
    when 'permanent'
      @conds << ConditionIsPermanent.new
    when 'primary'
      @conds << ConditionIsPrimary.new
    when 'secondary'
      @conds << ConditionIsSecondary.new
    when 'front'
      @conds << ConditionIsFront.new
    when 'back'
      @conds << ConditionIsBack.new
    when 'booster'
      @conds << ConditionIsBooster.new
    when 'promo'
      @conds << ConditionIsPromo.new
    when 'reprint'
      @conds << ConditionIsReprint.new
    when 'reserved'
      @conds << ConditionIsReserved.new
    when 'scryland'
      @conds << ConditionIsScryland.new
    when 'scuttleback'
      @conds << ConditionIsScuttleback.new
    when 'shockfetch'
      @conds << ConditionIsShockfetch.new
    when 'spell'
      @conds << ConditionIsSpell.new
    when 'timeshifted'
      @conds << ConditionIsTimeshifted.new
    when 'staple'
      @conds << ConditionIsStaple.new
    when 'unique'
      @conds << ConditionIsUnique.new
    when 'vanilla'
      @conds << ConditionIsVanilla.new
    when 'hugo'
      @conds << ConditionIsHugo.new
    when 'searle'
      @conds << ConditionIsSearle.new
    when 'marisa'
      @conds << ConditionIsMarisa.new
    when 'mable'
      @conds << ConditionIsMable.new
    end
    @simple = @conds.all?(&:simple?)
  end

  def to_s
    "any:#{maybe_quote(@query)}"
  end
end

# frozen_string_literal: true

# https://github.com/mtgjson/mtgjson/issues/462
class PatchBasicLandRarity < Patch
  def call
    basic_land_names = %w[Mountain Plains Swamp Island Forest]

    each_printing do |card|
      next unless basic_land_names.include?(card['name'])

      # Fix rarities of promo basics
      card['rarity'] = 'special' if %w[arena guru jr euro apac ptc].include?(card['set_code'])

      # As far as I can tell, Unglued basics were printed on separate black-bordered sheet
      # contrary to what Gatherer says
      card['rarity'] = 'basic' if card['set_code'] == 'ug'

      # Arabian Night Mountain is just a common
      card['rarity'] = 'common' if card['set_code'] == 'an'
    end
  end
end

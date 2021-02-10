# frozen_string_literal: true

class PatchHasBoosters < Patch
  def call
    each_set do |set|
      booster = set.delete('booster')
      set['has_boosters'] = if set['code'] == 'tsts'
                              # https://github.com/mtgjson/mtgjson/issues/584
                              false
                            else
                              !booster.nil?
                            end
    end
  end
end

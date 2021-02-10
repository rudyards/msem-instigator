# frozen_string_literal: true

class PatchUnstableBorders < Patch
  def call
    each_printing do |card|
      next unless card['set_code'] == 'ust'

      name = card['name']
      supertypes = (card['supertypes'] || [])
      subtypes = (card['subtypes'] || [])

      card['border'] = 'black' if name == 'Steamflogger Boss'

      card['border'] = 'none' if supertypes.include?('Basic') || subtypes.include?('Contraption')
    end
  end
end

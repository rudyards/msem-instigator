# frozen_string_literal: true

# Meld card numbers https://github.com/mtgjson/mtgjson/issues/420
class PatchEmnCardNumbers < Patch
  def call
    each_printing do |card|
      next unless card['set_code'] == 'emn'

      case card['name']
      when 'Chittering Host'
        card['number'] = '96b'
      when 'Hanweir Battlements'
        card['number'] = '204a'
      end
    end
  end
end

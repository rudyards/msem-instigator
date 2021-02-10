# frozen_string_literal: true

class PatchNormalizeColors < Patch
  def call
    each_printing do |card|
      color_codes = { 'White' => 'w', 'Blue' => 'u', 'Black' => 'b', 'Red' => 'r', 'Green' => 'g', 'W' => 'w', 'U' => 'u', 'B' => 'b',
                      'R' => 'r', 'G' => 'g' }
      colors = card['colors'] || []
      card['colors'] = colors.map { |c| color_codes.fetch(c) }.sort.join
    end
  end
end

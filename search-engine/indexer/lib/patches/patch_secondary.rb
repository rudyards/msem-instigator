# frozen_string_literal: true

class PatchSecondary < Patch
  def call
    each_printing do |card|
      next unless card['names']

      # https://github.com/mtgjson/mtgjson/issues/227
      if card['layout'] == 'split'
        # All primary
      elsif card['layout'] == 'double-faced'
        if !card['manaCost'].empty?
          # Primary side
        else
          card['secondary'] = true
        end
      elsif (card['layout'] == 'flip') || (card['layout'] == 'aftermath') || (card['layout'] == 'adventure')
        pp card['number']
        raise unless card['number'] =~ /[ab]\z/

        card['secondary'] = true if card['number'] =~ /b\z/
      elsif card['layout'] == 'meld'
        if card['manaCost'] || (card['name'] == 'Hanweir Battlements')
          # Primary side
        else
          card['secondary'] = true
        end
      elsif card['layout'] == 'normal' # tales/adventure hack
        if card['type'].include?("Tale") || card['type'].include?("Adventure")
          card['secondary'] = true
        else
        end
      else
        raise "Unknown multipart card layout: #{card['layout']} for #{card['name']}"
      end
    end
  end
end

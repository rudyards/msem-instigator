# frozen_string_literal: true

class PatchSecondary < Patch
  def call
    each_printing do |card|
      next unless card['names']
	  case card['layout']
	  when 'double-faced', 'adventure', 'modal_dfc', 'flip', 'meld', 'transform'
	    card['secondary'] = true if card['side'] == 'b'
	  when 'split'
	    # always primary
      else
        raise "Unknown multipart card layout: #{card['layout']} for #{card['name']}"
      end
    end
  end
end

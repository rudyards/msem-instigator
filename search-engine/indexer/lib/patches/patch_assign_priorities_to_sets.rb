# frozen_string_literal: true

class PatchAssignPrioritiesToSets < Patch
  def call
    each_set do |set|
      set['priority'] = priority(set)
    end
  end

  private

  def priority(set)
	case set['type'].downcase
	when 'errata'
	  1000 # Errata sets are just a way to apply Oracle erratas without creating any cards
	when 'masters', 'bundle'
	  -1   # Commonly reprints, some new cards
	when 'champions'
	  -5   # Higher than other special prints
	when 'promo'
	  -10  # Secret Lair, CHAMPIONS, SHRINE
	when 'masterpiece'
	  -12  # Masterpiece sets while they still exist
    else
      # Give all unlisted custom sets priority, newest first
	  if set['release_number']
	    set['release_number']
	  else
	    0
	  end
    end
  end
end

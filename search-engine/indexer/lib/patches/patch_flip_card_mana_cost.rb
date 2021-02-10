# frozen_string_literal: true

# Flip cards keep primary side's mana cost and cmc for gameplay reasons
# But we don't want to actually show it on their title line

class PatchFlipCardManaCost < Patch
  def call
    each_printing do |card|
      card['hide_mana_cost'] = true if (card['layout'] == 'flip') && card['secondary']
    end
  end
end

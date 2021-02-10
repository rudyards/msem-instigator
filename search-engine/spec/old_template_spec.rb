# frozen_string_literal: true

# Due to way mtgjson updates, old templates often stay for a while in db
# Let's make sure to prevent regressions at least
# These numbers decreasing is good. Increasing is bad.
describe 'Old templates' do
  include_context 'db'

  it do
    assert_count_cards %(o:"mana pool"), 2
  end

  it do
    # "Firesong and Sunspeaker" is an exception
    assert_count_cards %(o:"creature or player"), 2
  end

  it do
    assert_count_cards %(o:"~ can't be countered"), 1
  end

  ### On non-Gatherer cards only
  it do
    # Gifts Given
    assert_count_cards %(o:"his or her"), 1
    assert_count_cards %(o:"he or she"), 0
    assert_count_cards %(o:"him or her"), 0
  end

  # Robot Chicken
  it do
    assert_count_cards %(o:"token onto the battlefield"), 1
  end

  ### Recently fixed
  it do
    assert_count_cards 't:planeswalker -t:legendary', 0
  end

  it do
    assert_count_cards %(o:"can't be countered by spells or abilities"), 0
  end
end

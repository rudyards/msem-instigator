# frozen_string_literal: true

describe 'Any queries' do
  include_context 'db'

  it 'includes German name' do
    assert_search_equal %(foreign:"Abrupter Verfall"), %(de:"Abrupter Verfall")
    assert_search_equal %q(foreign:/\bvon der\b/), %q(de:/\bvon der\b/)
  end

  context 'French name' do
    it do
      assert_search_equal %(foreign:"Décomposition abrupte"), %(fr:"Décomposition abrupte")
    end
    it 'is case insensitive' do
      assert_search_equal %(foreign:"Décomposition abrupte"), %(foreign:"décomposition ABRUPTE")
    end
    it 'ignores diacritics' do
      assert_search_equal %(foreign:"Décomposition abrupte"), %(foreign:"Decomposition abrupte")
    end
  end

  it 'includes Italian name' do
    assert_search_equal %(foreign:"Deterioramento Improvviso"), %(it:"Deterioramento Improvviso")
  end

  it 'includes Japanese name' do
    assert_search_equal %(foreign:"血染めの月"), %(jp:"血染めの月")
  end

  it 'includes Russian name' do
    assert_search_equal %(foreign:"Кровавая луна"), %(ru:"Кровавая луна")
  end

  it 'includes Spanish name' do
    assert_search_equal %(foreign:"Puente engañoso"), %(sp:"Puente engañoso")
  end

  it 'includes Portuguese name' do
    assert_search_equal %(foreign:"Ponte Traiçoeira"), %(pt:"Ponte Traiçoeira")
  end

  it 'includes Korean name' do
    assert_search_equal %(foreign:"축복받은 신령들"), %(kr:"축복받은 신령들")
    assert_search_equal 'foreign:/축복받은/', 'kr:/축복받은/'
  end

  it 'includes Chinese Traditional name' do
    assert_search_equal %(foreign:"刻拉諾斯的電擊"), %(ct:"刻拉諾斯的電擊")
  end

  it 'includes Chinese Simplified name' do
    assert_search_equal %(foreign:"刻拉诺斯的电击"), %(cs:"刻拉诺斯的电击")
  end

  it 'wildcard' do
    # Searching cards, as languages are not attached to printings
    assert_search_equal_cards 't:planeswalker -ru:* de:*', 't:planeswalker e:c14,c18'
  end

  it 'only caes for full words (except CJK)' do
    assert_search_differ 'foreign:/red/', %q(foreign:/\bred\b/)
    assert_search_differ 'foreign:/电击/', %q(foreign:/\b电击\b/)
    assert_search_equal 'foreign:red', %q(foreign:/\bred\b/)
    assert_search_equal 'foreign:电击', 'foreign:/电击/'
  end
end

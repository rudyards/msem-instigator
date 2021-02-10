# frozen_string_literal: true

describe 'deck: search' do
  include_context 'db'

  it 'Unique names' do
    assert_search_equal %(deck:"Ingenious Machinists" or deck:"Woodland Warriors"), %(e:"Elves vs Inventors")
  end

  it 'Case insensitive' do
    assert_search_equal %(deck:"Teferi, Timebender"), %(deck:"Teferi Timebender")
    assert_search_equal %(deck:"Teferi, Timebender"), %(deck:"teferi timebender")
  end

  it 'Partial names' do
    assert_search_equal %(deck:"Amonkhet / Gideon"), %(deck:"Gideon, Martial Paragon")
  end

  it 'Each deck can be searched by set code and slug' do
    db.decks.each do |deck|
      cond = ConditionDeck.new("#{deck.set_code}/#{deck.slug}")
      cond.resolve_deck_name(db).should eq [deck]
    end
  end

  it 'Each deck can be searched by full set name and deck name' do
    db.decks.each do |deck|
      cond = ConditionDeck.new("#{deck.set_name} / #{deck.name}")
      cond.resolve_deck_name(db).should eq [deck]
    end
  end

  it 'Each deck can be searched by slug only' do
    db.decks.each do |deck|
      cond = ConditionDeck.new(deck.slug)
      cond.resolve_deck_name(db).should include deck
    end
  end

  it 'Each deck can be searched by deck name only' do
    db.decks.each do |deck|
      cond = ConditionDeck.new(deck.name)
      cond.resolve_deck_name(db).should include deck
    end
  end
end

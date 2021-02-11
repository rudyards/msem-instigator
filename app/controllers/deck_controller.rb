# frozen_string_literal: true

# This class governs the decklist visualizer
class DeckController < ApplicationController
  def show
    @deck = Deck.find_by(id: params[:id])
    @title = "Decklist: #{@deck.title}"
    render layout: 'no_search_box'
  end

  def create
    byebug
  end

  def new
    @title = 'New Decklist'
    render layout: 'no_search_box'
  end
  # Once you save a decklist to @cards, you can grab all of their types this way
  # @cards.first.card.types.first
end

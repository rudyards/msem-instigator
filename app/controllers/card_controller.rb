# frozen_string_literal: true

class CardController < ApplicationController
  def show
    set = params[:set]
    number = params[:id]
    @card = $CardDatabase.sets[set].printings.find { |cp| cp.number == number } if $CardDatabase.sets[set]
    if @card
      @title = @card.name
    else
      render_404
    end
  end

  def gallery
    set = params[:set]
    number = params[:id]
    @card = $CardDatabase.sets[set].printings.find { |cp| cp.number == number } if $CardDatabase.sets[set]

    if @card
      first_printing = @card.printings.first
      if @card == first_printing
        @title = @card.name
        page = [1, params[:page].to_i].max
        @total_printings = @card.printings.size
        @printings = paginate_by_set(@card.printings, page)
      else
        redirect_to set: first_printing.set_code, id: first_printing.number
      end
    else
      render_404
    end
  end

  # Logic tested in CLIFrontend, probably should be moved to database
  # as this untested copypasta is nasty
  # FIXME: And now it's not even the same anymore
  def index
    @search = (params[:q] || '').strip
    page = [1, params[:page].to_i].max

    unless @search.present?
      @empty_page = true
      @cards = []
      return
    end

    # Temporary issue with bots
    logger.info "PAGINATED #{params.inspect} BY USERAGENT: #{request.headers['HTTP_USER_AGENT']}" if params[:page]

    if request.headers['HTTP_USER_AGENT'] =~ (/MJ12bot/) && params[:page]
      render_403
      return
    end

    # End of temporary bot code

    @title = @search
    query = Query.new(@search, params[:random_seed])
    @seed = query.seed
    results = $CardDatabase.search(query)
    @warnings = results.warnings
    @cards = results.card_groups.map do |printings|
      choose_best_printing(printings)
    end

    case query.view
    when 'full'
      # force detailed view
      @cards = @cards.paginate(page: page, per_page: 10)
      render 'index_full'
    when 'images'
      @cards = @cards.paginate(page: page, per_page: 60)
      render 'index_images'
    when 'text'
      @cards = @cards.paginate(page: page, per_page: 60)
      render 'index_text'
    else
      # default view
      @cards = @cards.paginate(page: page, per_page: 25)
    end
  end

  private

  def choose_best_printing(printings)
    best_printing = printings.find { |cp| ApplicationHelper.card_picture_path(cp) } || printings.first
    [best_printing, printings]
  end
end

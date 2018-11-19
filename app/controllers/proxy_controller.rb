class ProxyController < ApplicationController
  def show
    @title = "Proxies"
    render :layout => 'no_search_box'
  end

  def search
    @title = "Printable Proxies"
    # Search takes its params from the decklist textarea in show
    @search = params[:decklist] || ""



    @cards = []
    # split the form into separate lines
    @searches = @search.split("\n")
    # loop through the separate lines
    # find the integer if there is one, assign to number and remove from search string
    @searches.each do |thissearch|
        # We create a new query, specifically searching just by name
        number = thissearch.split(" ")[0]
        if (number.to_i == 0)
            number = 1
        else
            number = number.to_i
            thissearch = thissearch.split(" ")[1..-1].join(" ")
        end


        searchTerm = "n:" + '"' + thissearch.strip + '"'
        puts(searchTerm)
        query = Query.new(searchTerm, params[:random_seed])
        @seed = query.seed
        # We save the results of our database search to a variable named results
        results = $CardDatabase.search(query)

        number.times do
            @cards += results.card_groups.map do |printings|
                choose_best_printing(printings)
            end
        end
        puts("Suceeded")
    end



    render :layout => 'no_search_box'
  end










  def choose_best_printing(printings)
    puts (printings)
    # best_printing   = printings.find do |cp| 
    #     # puts("choose_best_printing: cp=#{cp.inspect}")
    #     ApplicationHelper.card_picture_path(cp) 
    # end
    best_printing = printings[1] ||= printings[0]
    best_printing
  end
end

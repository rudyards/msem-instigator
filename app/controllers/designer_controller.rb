class DesignerController < ApplicationController
  def index
    @title = "Designers"
    @designers = Hash.new(0)
    $CardDatabase.sets.each_value do |set|
      set.printings.each do |printing|
        @designers[printing.designer] += 1
      end
    end
    @designers = @designers.sort
  end

  def show
    id = params[:id]
    @designer = $CardDatabase.designers[id]
    unless @designer
      render_404
      return
    end

    @total = @designer.printings.size
    @title = @designer.name
    page = [1, params[:page].to_i].max
    @printings = paginate_by_set(@designer.printings, page)
  end
end

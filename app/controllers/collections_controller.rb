class CollectionsController < ApplicationController

  def index
    @collections = Collection.all
    authorize @collections
  end

  def show
    @collection = Collection.find(params[:id])
    # authorize @collections
  end

  def popular
    @collections = Collection.limit(10).order('volume desc')
    # authorize @collections
  end

def drops

end 

def pop_today

end 

end

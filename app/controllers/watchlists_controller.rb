class WatchlistsController < ApplicationController
  before_action :set_watchlist, only: %i[show update]

  def show; end

  def update
    if @watchlist.update(watchlist_params)
      redirect_to watchlist_path
    else
      render :edit
    end
  end

  private

  def set_watchlist
    @watchlist = Watchlist.find(params[:id])
    authorize @watchlist
  end

  def watchlist_params
    params.require(:watchlist).permit(:collection)
  end
end

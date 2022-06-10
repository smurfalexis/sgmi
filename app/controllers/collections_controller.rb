NFT_OWNERS = "No Data"
NFT_SUPPLY = "No Data"

class CollectionsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]
  def index
    @nft_owners = NFT_OWNERS
    @nft_supply = NFT_SUPPLY
    @watchlist_items = current_user.watchlist_items if current_user
    @collections = policy_scope(Collection)
    if params[:search] && params[:search][:category].present?
      @collections = policy_scope(@collections.search_by_category(params[:search][:category]))
    elsif params[:search] && params[:search][:keyword].present?
      @key_word = params[:search][:keyword]
      @collections = policy_scope(@collections.search_by_keyword(params[:search][:keyword]))
    elsif params[:ajax_search].present?
      @collections = policy_scope(@collections.search_by_keyword(params[:ajax_search]))
    else
      @collections = []
    end
    respond_to do |format|
      format.html # Follow regular flow of Rails
      format.json { render json: @collections }
    end
  end

  def show
    @nft_owners = NFT_OWNERS
    @nft_supply = NFT_SUPPLY
    @collection = Collection.find(params[:id])
    authorize @collection
  end

end

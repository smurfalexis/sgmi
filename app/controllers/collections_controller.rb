class CollectionsController < ApplicationController
  def index
    @collections = policy_scope(Collection)
    if params[:search] && params[:search][:category].present?
      @collections = policy_scope(@collections.search_by_category(params[:search][:category]))
    elsif params[:search] && params[:search][:keyword].present?
      @collections = policy_scope(@collections.search_by_keyword(params[:search][:keyword]))
    elsif params[:ajax_search].present?
      @collections = policy_scope(@collections.search_by_keyword(params[:ajax_search]))
    else
      @collections = []
    end
    respond_to do |format|
      format.html # Follow regular flow of Rails
      format.text { render partial: 'pages/collections_list', locals: { collections: @collections }, formats: [:html] }
    end
  end

  def show
    @collection = Collection.find(params[:id])
    authorize @collection
  end

end
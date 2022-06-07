class CollectionsController < ApplicationController
  def index
    @collections = policy_scope(Collection)
    @key_word = params[:search]['keyword']
    if params[:search][:category].present?
      @collections = policy_scope(@collections.search_by_category(params[:search][:category]))
    elsif params[:search][:keyword].present?
      @collections = policy_scope(@collections.search_by_keyword(params[:search][:keyword]))
    else
      @collections = []
    end
  end

  def show
    @collection = Collection.find(params[:id])
    authorize @collection
  end
end

class CollectionsController < ApplicationController

  def index
    @collections = policy_scope(Colletion.where(nil))
    @collections = policy_scope(@collections.search_by_category(params[:search][:category])) if params[:search][:category].present?
    @collections = policy_scope(@collections.search_by_keyword(params[:search][:keyword])) if params[:search][:keyword].present?
  end

  def show
    @collection = Collection.find(params[:id])
  end

end

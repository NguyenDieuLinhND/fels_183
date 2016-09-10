class CategoriesController < ApplicationController
  load_and_authorize_resource

  def index
    @search = Category.ransack params[:q]
    @categories = @search.nil? ? Category.all : @search.result
    @categories = @categories.order(updated_at: :desc).paginate page: params[:page],
      per_page: Settings.size
  end

  def show
    @words = @category.words.order(updated_at: :desc).paginate page: params[:page],
      per_page: Settings.size_word_in_category
  end
end

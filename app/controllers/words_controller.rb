class WordsController < ApplicationController
  before_action :load_category, only: :index

  def index
    params[:word_status] ||= Settings.status_word[:all]
    @words = Word.in_category(params[:category_id]).send params[:word_status],
      current_user.id
    @words = @words.order(updated_at: :desc).paginate page: params[:page],
      per_page: Settings.size_word
  end

  private
  def load_category
    @categories = Category.all.collect{|category| [category.name, category.id]}
  end
end

class Admin::WordsController < Admin::BaseController
  before_action :load_categories, only: :new

  def new
    @word = Word.new
    @word.answers.build
  end

  def create
    @word = Word.new word_params
    if @word.save
      flash[:success] = t "flash.create_success"
      redirect_to admin_words_path
    else
      render :new
    end
  end

  private
  def word_params
    params.require(:word).permit :name, :category_id,
      answers_attributes: [:id, :word_id, :answer_content, :is_correct, :_destroy]
  end

  def load_categories
    @category_selects = Category.all.collect{|category| [category.name, category.id]}
  end
end

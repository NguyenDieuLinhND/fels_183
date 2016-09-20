class Admin::WordsController < Admin::BaseController
  before_action :load_categories, only: [:new, :edit]
  before_action :find_word, only: [:edit, :update, :show, :destroy]

  def index
    @search = Word.ransack params[:q]
    @words = @search.nil? ? Word.all : @search.result
    @words = @words.order("created_at desc").paginate page: params[:page],
      per_page: Settings.size
  end

  def new
    @word = Word.new
    @word.answers.build
  end

  def create
    @word = Word.new word_params
    if @word.save
      flash[:success] = t "flash.create_success"
      redirect_to admin_words_path @word
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @word.update_attributes word_params
      flash[:success] = t "flash.edit_success"
      redirect_to admin_words_path @word
    else
      render :edit
    end
  end

  def destroy
    if @word.destroy
      flash[:success] = t "flash.delete_success"
      redirect_to admin_words_path
    else
      flash[:danger] = t "flash.delete_failed"
      redirect_to admin_words_path
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

  def find_word
    @word = Word.find_by id: params[:id]
    if @word.nil?
      flash[:danger] = t "flash.word_nil"
      redirect_to admin_words_path
    end
  end
end

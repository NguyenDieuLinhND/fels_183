class StaticPagesController < ApplicationController
  def home
    if user_signed_in?
      @word_learned = Word.learned current_user.id
      @lessons = current_user.lessons.includes :category
      @lessons = @lessons.order(updated_at: :desc).
        paginate page: params[:page], per_page: Settings.size_lesson
    end
  end
end

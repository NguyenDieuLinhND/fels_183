class StaticPagesController < ApplicationController
  def home
    if user_signed_in?
      @word_learned = Word.learned current_user.id
      @lessons = if params[:search_name].present?
        Lesson.search_lesson current_user.id, params[:search_name]
      else
        current_user.lessons.includes :category
      end
      @lessons = @lessons.order(updated_at: :desc).
        paginate page: params[:page], per_page: Settings.size_lesson
    end
  end
end

class LessonsController < ApplicationController
  load_and_authorize_resource

  def create
    @lesson = current_user.lessons.new lesson_params
    if @lesson.save
      redirect_to lesson_path @lesson
    else
      redirect_to :back
    end
  end

  def show
  end

  def update
  end

  private
  def lesson_params
    params.require(:lesson).permit :category_id, results_attributes: [:id, :answer_id]
  end
end

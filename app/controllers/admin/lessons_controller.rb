class Admin::LessonsController < Admin::BaseController
  load_and_authorize_resource

  def index
    @lessons = if params[:search_name].present?
      Lesson.joins(:category).where("categories.name LIKE '%#{params[:search_name]}%'")
    else
      Lesson.includes :category
    end
    @lessons = @lessons.order(created_at: :desc).paginate page: params[:page],
      per_page: Settings.size_lesson
  end
end

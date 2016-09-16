class LessonWorker
  include Sidekiq::Worker

  sidekiq_options retry: false

  def perform lesson_id
    lesson = Lesson.find_by id: lesson_id
    LessonMailer.lesson_finished_email(lesson).deliver_now
  end
end

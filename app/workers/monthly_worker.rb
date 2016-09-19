class MonthlyWorker
  include Sidekiq::Worker

  def perform user_id, word_count
    LessonMailer.monthly_email(user_id, word_count).deliver_now
  end
end

class LessonMailer < ApplicationMailer
  def remind_email lesson
    @user = lesson.user
    @lesson = lesson
    mail to: @user.email, subject: I18n.t("mail.remind_subject")
  end
end

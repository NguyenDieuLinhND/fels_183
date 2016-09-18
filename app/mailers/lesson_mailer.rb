class LessonMailer < ApplicationMailer
  def remind_email lesson
    @user = lesson.user
    @lesson = lesson
    mail to: @user.email, subject: I18n.t("mail.remind_subject")
  end

  def monthly_email user, wordcount
    @wordcount = wordcount
    @user = user
    mail to: @user.email, subject: I18n.t("mail.monthly_subject")
  end
end

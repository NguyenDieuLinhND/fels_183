module LessonsHelper
  def time datetime
    datetime.strftime t("format_time")
  end
end

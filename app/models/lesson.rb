class Lesson < ApplicationRecord
  belongs_to :category
  belongs_to :user

  has_many :results, dependent: :destroy

  before_create :build_result
  after_create :send_remind_email

  validates :category, presence: true
  validate :category_word_count

  accepts_nested_attributes_for :results, reject_if: proc {|attribute|
    attribute[:answer_id].blank?}

  enum status: [:init, :testing, :checked]

  def build_result
    category.words.shuffle().take(Settings.word.minimum).each do |word|
      self.results.build word_id: word.id
    end
  end

  def update_time_status
    if init?
      update_attributes started_at: Time.zone.now, status: :testing
    elsif testing?
      update_attributes spent_time: calculated_spent_time
    end
  end

  def calculated_spent_time
    time = Time.zone.now - started_at
    time > Settings.duration ? Settings.duration : time
  end

  def time_out?
    checked? || Time.zone.now > started_at + Settings.duration
  end

  def remaining_time
    init? || testing? ? Settings.duration - (Time.zone.now - started_at).to_i : 0
  end

  private
  def category_word_count
    unless self.category && self.category.words.count >= Settings.word.minimum
      self.errors.add :category, I18n.t("lesson.learned_all")
    end
  end

  def send_remind_email
    LessonMailer.delay(run_at: Settings.email_delay.seconds.from_now,
      target_id: self.id).remind_email self
  end
end

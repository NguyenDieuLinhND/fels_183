class Lesson < ApplicationRecord
  belongs_to :category
  belongs_to :user

  has_many :results, dependent: :destroy

  before_create :build_result

  validates :category, presence: true
  validate :category_word_count

  accepts_nested_attributes_for :results, reject_if: proc {|attribute|
    attribute[:answer_id].blank?}

  def build_result
    category.words.shuffle().take(Settings.word.minimum).each do |word|
      self.results.build word_id: word.id
    end
  end

  private
  def category_word_count
    unless self.category && self.category.words.count >= Settings.word.minimum
      self.errors.add :category, I18n.t("lesson.learned_all")
    end
  end
end

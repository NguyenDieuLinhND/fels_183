class Word < ApplicationRecord
  belongs_to :category

  has_many :answers, dependent: :destroy
  has_many :results, dependent: :destroy

  accepts_nested_attributes_for :answers,
    reject_if: proc {|attribute| attribute[:answer_content].blank?},
    allow_destroy: true

  validates :name, presence: true

  QUERY_WORD_LEARNED = "id IN (SELECT results.word_id FROM results INNER JOIN
    lessons ON lessons.id = results.lesson_id WHERE lessons.user_id = :user_id
    GROUP BY results.word_id)"
  QUERY_WORD_NOT_LEARNED = "id NOT IN (SELECT results.word_id FROM results INNER JOIN
    lessons ON lessons.id = results.lesson_id WHERE lessons.user_id = :user_id
    GROUP BY results.word_id)"

  scope :learned, -> user_id{where QUERY_WORD_LEARNED, user_id: user_id}
  scope :not_learned, -> user_id{where QUERY_WORD_NOT_LEARNED, user_id: user_id}
  scope :show_all, -> user_id{}
  scope :in_category, -> category_id do
    where category_id: category_id if category_id.present?
  end
end

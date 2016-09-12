class Answer < ApplicationRecord
  belongs_to :word

  has_many :results, dependent: :destroy

  validates :answer_content, presence: true
end

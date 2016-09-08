class Word < ApplicationRecord
  belongs_to :category

  has_many :answers, dependent: :destroy
  has_many :results, dependent: :destroy

  accepts_nested_attributes_for :answers,
    reject_if: proc {|attribute| attribute[:answer_content].blank?},
    allow_destroy: true

  validates :name, presence: true
end

class VocabularyTest < ApplicationRecord
  belongs_to :user
  belongs_to :homework

  validates :vocabulary_score,
            numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 10 }

  validates :sentence_score,
            numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 2 }
  validates :test_date, presence: true
  validates :homework_id,
            uniqueness: {
              scope: :user_id,
              message: "はすでに登録されています"
            }
end

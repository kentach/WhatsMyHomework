class VocabularyTest < ApplicationRecord
  belongs_to :user
  belongs_to :homework

  validates :vocabulary_score,
            numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 10 }

  validates :sentence_score,
            numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 2 }
  def total_score
    vocabulary_score + sentence_score
  end
end

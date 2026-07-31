class Homework < ApplicationRecord
  validates :title, presence: true
  validates :status, presence: true
  validates :test_start_date, presence: true
  validates :test_end_date, presence: true

  belongs_to :classroom
  belongs_to :user
  has_many :tasks, dependent: :destroy
  has_many :vocabulary_tests, dependent: :destroy

  accepts_nested_attributes_for :tasks, allow_destroy: true, reject_if: :all_blank

  enum status: { draft: "draft", published: "published" }

  # adminの検索機能
  def self.ransackable_attributes(auth_object = nil)
    %w[
      title
      status
      test_start_date
    ]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[classroom user]
  end
end

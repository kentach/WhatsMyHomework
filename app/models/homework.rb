class Homework < ApplicationRecord
  validates :title, presence: true
  validates :status, presence: true
  validates :test_start_date, presence: true
  validates :test_end_date, presence: true

  belongs_to :classroom
  has_many :tasks, dependent: :destroy

  #ransack
  # 検索可能なカラムを許可する
  def self.ransackable_attributes(auth_object = nil)
    %w[
      title
      content
      created_at
      updated_at
      classroom_id
    ]
  end

  # 関連も検索したい場合
  def self.ransackable_associations(auth_object = nil)
    %w[classroom]
  end
end

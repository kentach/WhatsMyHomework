class Task < ApplicationRecord
  validates :name, presence: true
  validates :user_id, uniqueness: { scope: :task_id }
  has_many :task_completions, dependent: :destroy
  belongs_to :homework
end

class Classroom < ApplicationRecord
  has_many :users, dependent: :nullify
  has_many :homeworks, dependent: :destroy
  has_many :notification_classrooms, dependent: :destroy
  has_many :notification, through: :notification_classrooms

  def self.ransackable_attributes(auth_object = nil)
    %w[eiken_level]
  end
end

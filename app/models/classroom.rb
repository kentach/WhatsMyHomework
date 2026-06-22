class Classroom < ApplicationRecord
  has_many :users, dependent: :nullify
  has_many :homeworks, dependent: :destroy

  def self.ransackable_attributes(auth_object = nil)
    %w[eiken_level]
  end
end

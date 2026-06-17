class Classroom < ApplicationRecord
  has_many :homeworks, dependent: :destroy
end

class NotificationClassroom < ApplicationRecord
  belongs_to :classroom
  belongs_to :notification
end

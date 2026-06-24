class CreateNotificationClassrooms < ActiveRecord::Migration[7.2]
  def change
    create_table :notification_classrooms do |t|
      t.references :notification, null: false, foreign_key: true
      t.references :classroom, null: false, foreign_key: true
      t.timestamps
    end
  end
end

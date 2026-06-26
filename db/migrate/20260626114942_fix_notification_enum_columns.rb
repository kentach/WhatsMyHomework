class FixNotificationEnumColumns < ActiveRecord::Migration[7.2]
  def up
    change_column :notifications, :status, :integer,
      using: "CASE status::text WHEN 'draft' THEN 0 WHEN 'published' THEN 1 ELSE 0 END",
      default: 0,
      null: false

    change_column :notifications, :notification_type, :integer,
      using: "CASE notification_type::text WHEN 'homework_correction' THEN 0 WHEN 'monthly_vocab_test' THEN 1 WHEN 'event' THEN 2 WHEN 'eiken_result' THEN 3 WHEN 'information' THEN 4 WHEN 'others' THEN 5 ELSE 0 END"

    change_column :notifications, :target_type, :integer,
      using: "CASE target_type::text WHEN 'all_classes' THEN 0 WHEN 'specific_class' THEN 1 ELSE 0 END"
  end

  def down
    change_column :notifications, :status, :string, default: "draft"
    change_column :notifications, :notification_type, :string
    change_column :notifications, :target_type, :string
  end
end
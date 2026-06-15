class Homework < ActiveRecord::Migration[7.2]
  def change
    create_table :homeworks do |t|
      t.string :title, null: false
      t.text :content
      t.datetime :published_at
      t.string :status, null: false, default: "draft"
      t.datetime :test_start_date, null: false
      t.datetime :test_end_date, null: false
      t.references :user, null: false, foreign_key: true
      t.references :classroom, null: false, foreign_key: true

      t.timestamps
    end
  end
end

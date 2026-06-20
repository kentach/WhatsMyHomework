class CreateTasks < ActiveRecord::Migration[7.2]
  def change
    create_table :tasks do |t|
      t.string :name, null: false
      t.text :description
      t.references :homework, foreign_key: true

      t.timestamps
    end
  end
end

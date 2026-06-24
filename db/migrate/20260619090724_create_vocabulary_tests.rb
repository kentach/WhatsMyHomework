class CreateVocabularyTests < ActiveRecord::Migration[7.2]
  def change
    create_table :vocabulary_tests do |t|
      t.references :user, null: false, foreign_key: true
      t.references :homework, null: false, foreign_key: true
      t.integer :vocabulary_score, null: false, default: 0
      t.integer :sentence_score, null: false, default: 0
      t.date    :test_date,  null: false, default: -> { "CURRENT_DATE" }

      t.timestamps
    end
  end
end

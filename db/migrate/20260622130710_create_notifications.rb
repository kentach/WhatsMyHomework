class CreateNotifications < ActiveRecord::Migration[7.2]
  def change
    create_table :notifications do |t|
      t.string :title, null: false
      t.text :content, null: false
      t.string :notification_type   # 通知の種類（単語テスト変更など）
      t.string :target_type         # 全クラスか特定のクラスか
      t.datetime :published_at
      t.string :status, null: false, default: "draft"
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end

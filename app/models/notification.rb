class Notification < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true
  validates :notification_type, presence: true
  validates :status, presence: true

  belongs_to :user
  has_many :notification_classrooms, dependent: :destroy
  has_many :classrooms, through: :notification_classrooms
  enum target_type: { all_classrooms: "全クラス", class_message: "クラス別" }
  enum notification_type: { correction: "宿題の訂正", monthly_vocab_test: "月例単語テスト", other: "その他" }
end

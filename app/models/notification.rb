class Notification < ApplicationRecord
  validates :title, presence: true                          # 通知タイトル
  validates :content, presence: true                        # 通知内容
  validates :notification_type, presence: true              # 通知の種別
  validates :target_type, presence: true                    # どのクラス対象か
  validates :status, presence: true                         # 状態

  belongs_to :user
  has_many :notification_classrooms, dependent: :destroy
  has_many :classrooms, through: :notification_classrooms

  enum target_type: {
    all_classes: 0,       # クラス全て
    specific_class: 1,     # 特定のクラス
  }

  enum notification_type: {
    homework_correction: 0, # 宿題の訂正
    monthly_vocab_test: 1,  # 月例単語テスト
    event: 2,               # イベント
    eiken_result: 3,        # 英検結果
    information: 4,         # お知らせ
    others: 5               # その他
  }

  enum status: {
    draft: 0,      # 下書き
    published: 1,  # 公開中
}

  def self.ransackable_attributes(auth_object = nil)
    %w[
      title
      notification_type
    ]
  end

  # 関連も検索したい場合
  def self.ransackable_associations(auth_object = nil)
    %w[classrooms]
  end
end

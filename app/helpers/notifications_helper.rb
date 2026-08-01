module NotificationsHelper
  def display_time(datetime)
    if datetime.to_date == Date.current # Date.current: 現在の日付を返す
      datetime.strftime("%H:%M") # strftime: 日時を好きなフォーマット(書式)の文字列に変換する」メソッド
    else
      datetime.strftime("%-m/%-d") # %- の - は「先頭の 0 を省く」
    end
  end

  def filter_active?(value)
    current = params.dig(:q, :notification_type_eq)
    value.nil? ? current.blank? : current == value.to_s
    # blank? 中身が空ならtrueを返す
    # to_s：「文字列」に変換する
  end

  NOTIFICATION_TYPE_BADGES = {
  "homework_correction" => { label: "宿題の訂正", color: "info" },
  "monthly_vocab_test"  => { label: "月例単語テスト", color: "success" },
  "event"               => { label: "イベント", color: "primary" },
  "eiken_result"        => { label: "英検結果", color: "warning" },
  "information"         => { label: "お知らせ", color: "secondary" },
  "others"              => { label: "その他", color: "dark" }
  }.freeze

  def notification_type_badge(notification)
    badge = NOTIFICATION_TYPE_BADGES[notification.notification_type]
    # 上記のハッシュ（Hash）から値を取り出して、badgeに格納
    return unless badge

    content_tag(:span, badge[:label], class: "badge bg-#{badge[:color]}")
    # content_tagはHTMLを生成する
    # ハッシュからキーを取り出す
  end

  # 通知の一覧ページの種別ラベル
  def notification_target_label(notification)
    if notification.specific_class?
      content_tag(:span) do
        content_tag(:i, "", class: "fa-solid fa-user-group") +
        "#{notification.classrooms.map(&:name).join("・")}"
      end
    elsif notification.all_classes?
      content_tag(:span) do
        content_tag(:i, "", class: "fa-solid fa-users") + "全クラス"
        # ""の理由は、アイコンは文字が空であるから。
      end
    end
  end

  # クラス名を最初の10文字のみ表示するロジック
  def classroom_names(notification, length: 10)
    names = notification.classrooms.map(&:name).join("、").presence
    # presence: 値が存在すればその値を返し、空なら nil を返す
    truncate(names, length: length, omission: "…") || "未設定"
    # 最大文字数 # 省略したことを表す文字
  end

  # 通知の種別分けボタン
  def notification_filter_buttons
    types = Notification.notification_types
    {
      "すべて"         => nil,
      "宿題の訂正"     => types["homework_correction"],
      "月例単語テスト" => types["monthly_vocab_test"],
      "イベント"       => types["event"],
      "英検結果"       => types["eiken_result"],
      "お知らせ"       => types["information"],
      "その他"         => types["others"]
    }
  end
end

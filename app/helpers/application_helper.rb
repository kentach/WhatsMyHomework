module ApplicationHelper
  def page_title(title = "")
    base_title = "What's My Homework?"
    title.present? ? "#{title} | #{base_title}" : base_title
  end

  def page_title(title = "", admin: false)
    base_title = admin ? "管理画面 | What's My Homework?" : "What's My Homework?"
    title.present? ? "#{title} | #{base_title}" : base_title
  end

  # 管理画面の「宿題の日付」を明記するロジック
  WEEKDAYS = WEEKDAYS = %w[日 月 火 水 木 金 土].freeze # オブジェクトを変更できなくするメソッド
  def format_date(date, with_time: false)
    return "-" if date.nil?

    base_format = with_time ? "%Y/%m/%d %H:%M" : "%Y/%m/%d"
    "#{date.strftime(base_format)}（#{WEEKDAYS[date.wday]}）"
    # date.wday  # 曜日を0〜6の数値で返す
    # date 日付を受け取る引数
  end

  # 通知・宿題で使う公開・非公開を分けるロジック
  def published_or_draft?(resource)
    if resource.published?
      content_tag(:span, "公開中", class: "badge bg-success")
    else
      content_tag(:span, "下書き中", class: "badge bg-warning")
    end
  end
end

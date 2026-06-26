module ApplicationHelper
  def page_title(title = "")
    base_title = "What's My Homework?"
    title.present? ? "#{title} | #{base_title}" : base_title
  end

  def page_title(title = "", admin: false)
    base_title = admin ? "管理画面 | What's My Homework?" : "What's My Homework?"
    title.present? ? "#{title} | #{base_title}" : base_title
  end

  #　管理画面の「宿題の日付」を明記するロジック
  WEEKDAYS = %w(日 月 火 水 木 金 土).freeze # オブジェクトを変更できなくするメソッド
  def date_format_with_weekday(date)
    return "" if date.nil?
    "#{date.strftime('%Y/%m/%d')}（#{WEEKDAYS[date.wday]}）"
  end
end

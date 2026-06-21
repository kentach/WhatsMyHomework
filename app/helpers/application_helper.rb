module ApplicationHelper
  def page_title(title = "")
    base_title = "What's My Homework?"
    title.present? ? "#{title} | #{base_title}" : base_title
  end

  def page_title(title = "", admin: false)
    base_title = admin ? "管理画面 | What's My Homework?" : "What's My Homework?"
    title.present? ? "#{title} | #{base_title}" : base_title
  end
end

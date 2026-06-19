module ApplicationHelper
  def page_title(title = "")
    base_title = "What's My Homework?"
    title.present? ? "#{title} | #{base_title}" : base_title
  end
end
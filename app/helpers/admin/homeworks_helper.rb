module Admin::HomeworksHelper
  def published_or_draft?(homework)
    if homework.published?
      content_tag(:span, "公開中", class: "badge bg-success")
    else
      content_tag(:span, "下書き中", class: "badge bg-warning")
    end
  end
end

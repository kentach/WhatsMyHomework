module HomeworksHelper
  def test_period(homework)
    start_date = homework.test_start_date.strftime("%m月%d日")
    end_date   = homework.test_end_date&.strftime("%m月%d日")
    "#{start_date} 〜 #{end_date}"
  end

  def pdf_link(task)
    return unless task.pdf.attached?
    link_to url_for(task.pdf), target: "_blank", class: "homework-show-pdf-link" do
      content_tag(:i, nil, class: "fas fa-file-pdf") + " #{task.pdf.filename}"
    end
  end
end

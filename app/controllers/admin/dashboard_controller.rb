class Admin::DashboardController < Admin::BaseController
  def index
    @homeworks_count     = Homework.count # 宿題の総数
    @recent_homeworks    = homeworks_with_classroom.order(updated_at: :desc).limit(20) # 最近投稿した宿題
    @draft_homeworks     = homeworks_with_classroom.draft # 下書きの宿題
    @published_homeworks = homeworks_with_classroom.published # 公開中の宿題
    @classrooms          = Classroom.all
  end

  private

  def homeworks_with_classroom
    Homework.includes(:classroom)
  end
end

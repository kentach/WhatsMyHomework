class Admin::DashboardController < Admin::BaseController
  def index
    @homeworks_count     = Homework.count # 宿題の総数
    @recent_homeworks    = Homework.includes(:classroom).order(updated_at: :desc).limit(20) # 最近投稿した宿題
    @draft_homeworks     = Homework.includes(:classroom).draft # 下書きの宿題
    @published_homeworks = Homework.includes(:classroom).published # 公開中の宿題
    @classrooms          = Classroom.all
  end
end

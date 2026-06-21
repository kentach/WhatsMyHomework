class Admin::DashboardController < Admin::BaseController
  layout "admin"
  def index
    @homeworks = Homework.all
    @published_homeworks = @homeworks.where(status: "published")
    @draft_homeworks = @homeworks.where(status: "draft")
    @classrooms = Classroom.all
    @recent_homeworks = @homeworks.order(created_at: :desc).limit(10)
  end
end

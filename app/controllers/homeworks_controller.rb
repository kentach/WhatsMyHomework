class HomeworksController < ApplicationController
  before_action :set_homework, only: [ :show ]

  def index
    @q = Homework.published.ransack(params[:q]) # 検索
    @homeworks = @q.result(distinct: true)
    @classrooms = Classroom.order(created_at: :asc) # 級のタブ

    if params[:classroom_id].present?
      @selected_classroom = Classroom.find(params[:classroom_id])
      @homeworks = @homeworks.where(classroom_id: params[:classroom_id])
    end

    @homeworks = @homeworks.order(created_at: :desc)
                            .includes(:classroom)
                            .page(params[:page])
                            .per(10)
  end

  def show
    @tasks = @homework.tasks
  end

  private

  def set_homework
    @homework = Homework.published.includes(:tasks).find(params[:id])
  end
end

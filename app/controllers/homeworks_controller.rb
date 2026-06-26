class HomeworksController < ApplicationController
  def index
    @q = Homework.published.ransack(params[:q]) #　検索
    @homeworks = @q.result(distinct: true).includes(:classroom)
    @classrooms = Classroom.order(created_at: :asc) # タブ

    if params[:classroom_id].present?
      @selected_classroom = Classroom.find(params[:classroom_id])
      @homeworks = @homeworks.where(classroom_id: params[:classroom_id])
    end

    @homeworks = @homeworks.order(created_at: :desc).page(params[:page]).per(10)
  end

  def show
    @homework = Homework.published.find(id: params[:id])
    @tasks = @homework.tasks
  end
end

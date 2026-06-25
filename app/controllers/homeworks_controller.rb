class HomeworksController < ApplicationController
  def index
    @q = Homework.published.ransack(params[:q])
    @homeworks = @q.result(distinct: true).includes(:classroom)

    @classrooms = Classroom.order(created_at: :asc) # タブ

    @selected_classroom = Classroom.find_by(id: params[:classroom_id])
    if @selected_classroom
      @homeworks = @homeworks.where(classroom_id: @selected_classroom.id)
    end
    
    @homeworks = @homeworks.order(created_at: :desc).page(params[:page]).per(10)
  end

  def show
    @homework = Homework.published.find(id:params[:id])
    @tasks = @homework.tasks
  end
end

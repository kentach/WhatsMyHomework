class HomeworksController < ApplicationController
  def index
    @classrooms = Classroom.all # タブ作成
    @q = Homework.ransack(params[:q]) # 検索機能ransack。ransack(params[:q])にすること。
    @homeworks = @q.result(distinct: true).includes(:classroom)
    @selected_classroom = Classroom.find_by(id: params[:classroom_id])

    if @selected_classroom
      @homeworks = @homeworks.where(classroom_id: @selected_classroom.id)
    end

    @homeworks = @homeworks.order(created_at: :desc).page(params[:page]).per(10)
  end

  def show
    @homework = Homework.find(params[:id])
    @tasks = @homework.tasks
  end
end

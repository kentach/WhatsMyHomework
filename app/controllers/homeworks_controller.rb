class HomeworksController < ApplicationController
  before_action :set_homework, only: [ :show ]

  def index
    @q = Homework.published.ransack(params[:q]) # 検索
    @homeworks = @q.result(distinct: true)

    if params[:classroom_id].present? # クラスによる絞り込み
      @selected_classroom = Classroom.find(params[:classroom_id])
      @homeworks = @homeworks.where(classroom_id: params[:classroom_id])
    end

    @homeworks = @homeworks.order(created_at: :desc) # 表示調整
                            .includes(:classroom)
                            .page(params[:page])
                            .per(10)

    @classrooms = Classroom.order(created_at: :asc) # 級のタブ
  end

  def show
    @tasks = @homework.tasks
  end

  private

  def set_homework
    @homework = Homework.published.includes(:tasks).find(params[:id])
    # 公開されている宿題に紐づくtasksを事前に一括取得
    # URLと一致する1件を取得
  end
end

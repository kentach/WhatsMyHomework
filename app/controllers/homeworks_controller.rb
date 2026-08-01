class HomeworksController < ApplicationController
  before_action :set_homework, only: [ :show ]

  def index
    @q = Homework.published.ransack(params[:q]) # 検索条件を渡して検索オブジェクトを作る(まだ検索してない)
    @homeworks = @q.result(distinct: true) # 実際に検索を実行し、重複なしの結果を取得する

    if params[:classroom_id].present? # クラスによる絞り込み
      @selected_classroom = Classroom.find(params[:classroom_id]) # params[:key名]
      @homeworks = @homeworks.where(classroom_id: params[:classroom_id]) # where(カラム: 値)
    end

    @homeworks = @homeworks.order(created_at: :desc) # 表示調整
                            .includes(:classroom)
                            .page(params[:page])
                            .per(10)

    @classrooms = Classroom.order(created_at: :asc) # 級のタブ
  end

  def show
    @tasks = @published_homework.tasks
    # show画面では個々のタスクを表示する
  end

  private

  def set_homework
    @published_homework = Homework.published.includes(:tasks).find(params[:id])
    # 公開されている宿題に紐づくtasksを事前に一括取得
    # URLと一致する1件を取得
  end
end

class Admin::HomeworksController < Admin::BaseController
  before_action :set_homework, only: [ :edit, :update, :destroy ]
  before_action :set_classrooms, only: [ :new, :edit, :create, :update ]

  def index
    @homeworks = paginate_homeworks(Homework.includes(:classroom))
  end

  def new # formで表示する内容
    @homework = Homework.new
    @homework.tasks.build
    # 親のインスタンス.関連名.build
    # この@homeworkに紐づく、新しいtaskを1つ作る
  end

  def create
    @homework = current_user.homeworks.build(homework_params) # userモデルにhas_many :homeworks
    if @homework.save
      redirect_to admin_root_path, notice: "宿題を作成しました"
    else
      flash.now[:danger] = "作成できませんでした。"
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @homework.update(homework_params)
      redirect_to admin_root_path, notice: "宿題を更新しました"
    else
      flash.now[:danger] = "更新できませんでした。"
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @homework.destroy!
    redirect_to admin_root_path, notice: "宿題を削除しました", status: :see_other
  end

  def draft
    @homeworks = paginate_homeworks(Homework.includes(:classroom).draft)
  end

  def published
    @homeworks = paginate_homeworks(Homework.includes(:classroom).published)
  end

  private

  def set_homework
    @homework = Homework.find(params[:id])
  end

  def set_classrooms # クラス一覧を取得する(プルダウン用)
    @classrooms = Classroom.all
  end

  def paginate_homeworks(scope)
    @q = scope.ransack(params[:q])
    @q.result(distinct: true)
      .order(updated_at: :desc)
      .page(params[:page])
      .per(20)
  end

  def homework_params
    params.require(:homework).permit(
      :title,
      :status,
      :test_start_date,
      :test_end_date,
      :classroom_id,
      tasks_attributes: [ :id, :name, :pdf, :_destroy ]
      # 関連名_attributes: [許可するキーの配列]
      # 関連するタスクのデータも一緒に保存できるようにするための許可設定
    )
  end
end

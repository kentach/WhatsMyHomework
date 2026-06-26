class Admin::HomeworksController < Admin::BaseController
  before_action :set_homework, only: [ :edit, :update, :destroy ]
  before_action :set_classrooms, only: [ :new, :edit, :create, :update ]

  def index
    @homeworks = paginate_homeworks(Homework.all)
  end

  def new # formで表示する内容
    @homework = Homework.new
    @homework.tasks.build
  end

  def create
    @homework = Homework.new(homework_params) # relationが存在しないので、この書き方
    @homework.user_id = current_user.id
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
    @homeworks = paginate_homeworks(Homework.draft)
  end

  def published
    @homeworks = paginate_homeworks(Homework.published)
  end

  private

  def set_homework
    @homework = Homework.find(params[:id])
  end

  def set_classrooms
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
    )
  end
end

class Admin::HomeworksController < Admin::BaseController
  layout "layouts/admin"
  before_action :authenticate_user!
  before_action :set_homework, only: [ :edit, :update, :destroy ]

  def index
    @q = Homework.ransack(params[:q])
    @homeworks = @q.result(distinct: true)
                   .order(updated_at: :desc) # result(distinct: true)の後にorderを記述する
                   .page(params[:page])
                   .per(20)
  end

  def new
    @homework = Homework.new
  end

  def create
    @homework = Homework.new(homework_params)
    @homework.user_id = current_user.id
    if @homework.save
      redirect_to admin_root_path, notice: "宿題を作成しました"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @homework.update(homework_params)
      redirect_to admin_root_path, notice: "宿題を更新しました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @homework.destroy!
    redirect_to admin_root_path, notice: "宿題を削除しました"
  end

  def draft
    @q = Homework.where(status: "draft").ransack(params[:q])
    @homeworks = @q.result(distinct: true)
                   .order(updated_at: :desc)
                   .page(params[:page])
                   .per(20)
  end

  def published
    @q = Homework.where(status: "published").ransack(params[:q])
    @homeworks = @q.result(distinct: true)
                   .order(updated_at: :desc)
                   .page(params[:page])
                   .per(20)
  end

  private

  def set_homework
    @homework = Homework.find(params[:id])
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

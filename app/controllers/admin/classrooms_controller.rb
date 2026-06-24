class Admin::ClassroomsController < Admin::BaseController
  layout "admin"
  before_action :authenticate_user!
  before_action :set_classroom, only: [ :edit, :update, :destroy ]

  def index
    @classrooms = Classroom.all
  end

  def new
    @classroom = Classroom.new
  end

  def create
    @classroom = Classroom.new(classroom_params)
    if @classroom.save
      redirect_to admin_classrooms_path, notice: "クラスを作成しました"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @classroom.update(classroom_params)
      redirect_to admin_classrooms_path, notice: "更新しました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @classroom.destroy!
    redirect_to admin_classrooms_path, notice: "削除しました", status: :see_other
  end

  private

  def set_classroom
    @classroom = Classroom.find(params[:id])
  end

  def classroom_params
    params.require(:classroom).permit(:name, :eiken_level)
  end
end

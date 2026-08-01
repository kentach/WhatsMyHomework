class Admin::UsersController < Admin::BaseController
  def index
    @users = User.all.order(created_at: :desc).page(params[:page]).per(20)
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "ユーザーを作成しました"
      redirect_to admin_users_path
    else
      render :new, status: :unprocessable_entity
      # renderは「同じフォームに、入力済みの内容とエラーメッセージを乗せて」再表示できる。
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "ユーザーを更新しました"
      redirect_to admin_users_path
    else
      render :edit, status: :unprocessable_entity
      # バリデーション失敗時のHTTPステータス(422)を返す
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy!
    # destroy!：例外(エラー)を発生させる
    flash[:notice] = "ユーザーを削除しました"
    redirect_to admin_users_path
  end

  private

  def user_params
    params.require(:user).permit(
      :name,
      :student_id,
      :password,
      :password_confirmation,
      :classroom_id
    )
  end
end

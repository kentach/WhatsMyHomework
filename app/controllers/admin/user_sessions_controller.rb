class Admin::UserSessionsController < Admin::BaseController
  skip_before_action :authenticate_user!
  skip_before_action :authenticate_admin!
  layout "layouts/admin"

  def new
  end

  def create
    user = User.find_by(student_id: params[:student_id])
    if user&.valid_password?(params[:password]) && user.admin?
      sign_in user
      redirect_to admin_root_path, notice: "ログインしました。"
    else
      flash.now[:alert] = "IDまたはパスワードが違います。"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    reset_session
    redirect_to admin_login_path, status: :see_other, notice: "ログアウトしました。"
  end
end
class Admin::BaseController < ApplicationController
  before_action :authenticate_user! # ログイン確認
  before_action :authenticate_admin! # 管理者確認
  layout "admin"

  private

  def authenticate_admin!
    if current_user.nil?
      flash[:danger] = "ログインしてください。"
      redirect_to admin_login_path

    elsif !current_user.admin?

      flash[:danger] = "管理者権限がありません。"
      redirect_to homeworks_path
    end
  end
end

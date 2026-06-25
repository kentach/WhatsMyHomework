class Admin::BaseController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_admin!
  layout "admin"

  private

  def not_authenticated
    flash[:warning] = t("defaults.flash_message.require_login")
    redirect_to admin_login_path
  end

  def authenticate_admin!
    redirect_to admin_login_path unless current_user&.admin?
  end
end

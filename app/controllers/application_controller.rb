class ApplicationController < ActionController::Base
  allow_browser versions: :modern
  add_flash_types :success, :danger
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters # 「生徒id」でログインできるように明示的に記述
    devise_parameter_sanitizer.permit(:sign_in, keys: [ :name, :student_id, :classroom_id, :password, :password_confirmation ])
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :name, :student_id, :classroom_id, :password, :password_confirmation ])
    devise_parameter_sanitizer.permit(:account_update, keys: [ :name, :student_id, :classroom_id, :password, :password_confirmation ])
  end
end

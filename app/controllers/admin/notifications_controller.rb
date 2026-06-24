class Admin::NotificationsController < Admin::BaseController
  layout "admin"
  before_action :authenticate_user!
  before_action :set_notification, only: [ :edit, :update, :destroy ]

  def index
    @notifications = Notification.includes(:classrooms, :user).order(updated_at: :desc)
    @draft_notifications      = @notifications.draft
    @scheduled_notifications  = @notifications.scheduled
    @published_notifications  = @notifications.published
  end

  def new
    @notification = Notification.new
  end

  def create
    @notification = current_user.notifications.build(notification_params)
    if @notification.save
      redirect_to admin_notifications_path, notice: "通知を新しく作成しました。"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @notification.update(notification_params)
      redirect_to admin_notifications_path, notice: "通知を更新しました。"
    else
      flash.now[:danger] = "更新できませんでした。"
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @notification.destroy!
    redirect_to admin_notifications_path, notice: "通知を削除しました。"
  end

  def draft
    @notifications = Notification.draft
                                  .page(params[:page]).per(20)
  end

  def published
    @notifications = Notification.published
                                  .page(params[:page]).per(20)
  end

  def scheduled
    @notifications = Notification.scheduled
                                  .page(params[:page]).per(20)
  end

  private

  def set_notification
    @notification = Notification.find(params[:id])
  end

  def notification_params
    params.require(:notification).permit(
        :title,
        :content,
        :notification_type,
        :target_type,
        :published_at,
        :status,
        classroom_ids: []
        )
  end
end

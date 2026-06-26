class Admin::NotificationsController < Admin::BaseController
  before_action :set_notification, only: [ :edit, :update, :destroy ]

  def index
    @notifications_count = Notification.count
    @recent_notifications = base_scope.page(params[:page]).per(20)
    @draft_notifications      = base_scope.draft.limit(20)
    @published_notifications  = base_scope.published.limit(20)
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
      flash.now[:alert] = "更新できませんでした。"
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @notification.destroy!
    redirect_to admin_notifications_path, notice: "通知を削除しました。"
  rescue ActiveRecord::RecordNotDestroyed
    redirect_to admin_notifications_path, alert: "削除できませんでした。"
  end

  def draft
    @notifications = base_scope.draft.page(params[:page]).per(20)
  end

  def published
    @notifications = base_scope.published.page(params[:page]).per(20)
  end

  private

  def base_scope
    Notification.includes(:user, :classrooms).order(updated_at: :desc)
  end

  def set_notification
    @notification = Notification.find(params[:id])
  end

  def notification_params
    params.require(:notification).permit(
        :title,
        :content,
        :notification_type,
        :target_type,
        :status,
        classroom_ids: []
        )
  end
end

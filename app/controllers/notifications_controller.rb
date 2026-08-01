class NotificationsController < ApplicationController
  before_action :published_notifications

  def index
    @q = published_notifications.ransack(params[:q])
    @notifications = @q.result(distinct: true)
                        .includes(:classrooms) # notificationモデルにhas_many :classrooms
                        .order(updated_at: :desc) # 更新された順
                        .page(params[:page]).per(7)
  end

  def show
    @notification = published_notifications.includes(:classrooms, :user).find(params[:id])

    base = published_notifications.order(updated_at: :desc, id: :desc)
    @prev_notification = base.where(
      "updated_at > ? OR (updated_at = ? AND id > ?)",
      @notification.updated_at,
      @notification.updated_at,
      @notification.id
    ).last

    @next_notification = base.where(
      "updated_at < ? OR (updated_at = ? AND id < ?)",
      @notification.updated_at,
      @notification.updated_at,
      @notification.id
    ).first
  end

  private

  def published_notifications
    Notification.published
  end
end

class NotificationsController < ApplicationController
  def index
    @q = Notification.published.ransack(params[:q])
    @notifications = @q.result(distinct: true)
                        .includes(:classrooms)
                        .order(updated_at: :desc)
                        .page(params[:page]).per(7)
  end

  def show
    @notification = Notification.published
                                  .includes(:classrooms, :user)
                                  .find(params[:id])
    base = Notification.published
                        .order(updated_at: :desc, id: :desc)
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
end

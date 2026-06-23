class NotificationsController < ApplicationController
  def index
    @notifications = Notification.includes(:classrooms)
                                 .where(status: "published")
                                 .order(created_at: :desc)
                                 .page(params[:page]).per(7)
  end

  def show
    @notification = Notification.includes(:classrooms, :user)
                                 .where(status: "published")
                                 .find(params[:id])
    base = Notification.where(status: "published").order(published_at: :desc, created_at: :desc)
    @prev_notification = base.where("(published_at > ?) OR (published_at IS NULL AND created_at > ?)",
                                     @notification.published_at || @notification.created_at,
                                     @notification.created_at).last
    @next_notification = base.where("(published_at < ?) OR (published_at IS NULL AND created_at < ?)",
                                     @notification.published_at || @notification.created_at,
                                     @notification.created_at).first
  end
end

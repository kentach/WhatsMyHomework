class NotificationsController < ApplicationController
  def index
    @notifications = Notification.includes(:classrooms)  
  end

  def show
    @notification = Notification.find(params[:id])
  end
end

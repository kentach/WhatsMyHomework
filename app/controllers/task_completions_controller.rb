class TaskCompletionsController < ApplicationController
  before_action :set_task, only: [ :create, :destroy ]

  def create
    current_user.complete!(@task)
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_back fallback_location: tasks_path }
    end
  end

  def destroy
    current_user.incomplete!(@task)
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_back fallback_location: tasks_path }
    end
  end

  private

  def set_task
    @task = Task.find(params[:task_id])
  end
end

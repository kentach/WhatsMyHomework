class TaskCompletionsController < ApplicationController
  before_action :set_task, only: [ :create, :destroy ]

  def create
    current_user.complete!(@task)
    redirect_to tasks_path # レンダリングされないと数字が更新されない為。
  end

  def destroy
    current_user.incomplete!(@task)
    redirect_to tasks_path
  end

  private

  def set_task
    @task = Task.find(params[:task_id])
  end
end

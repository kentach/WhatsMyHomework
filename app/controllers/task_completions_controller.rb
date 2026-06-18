class TaskCompletionsController < ApplicationController
  before_action :set_task

  def create
    task_record = current_user.task_completions.find_by(task: @task)
    #current_userのtask_completionsの中からtaskの一個一個を探す。

    if task_record
      task_record.destroy
      #taskがあれば、そのタスクを削除する。
    else
      current_user.task_completions.create!(task: @task)
      #taskがなければ、タスクにcompletedをつける。
    end

    respond_to do |format|
      format.turbo_stream
      format.html {redirect_back fallback_location: root_path}
    end
  end

  def destroy
    task_completion = current_user.task_completions.find_by(task: @task)
    task_completion&.destroy

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_back fallback_location: root_path }
    end
  end

  private

  def set_task
    @task = Task.find(params[:task_id])
  end
end

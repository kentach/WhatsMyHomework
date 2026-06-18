class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :task_completions, dependent: :destroy

  def completed?(task)
    task_completions.exists?(task: task)
  end

  def completed_homework?(homework)
    return false if homework.tasks.empty?
    # 宿題に紐づいているtask(一個一個の宿題のこと)がなければリターン。
  
    homework.tasks.count ==
      # 宿題に紐づいているtask(一個一個の宿題のこと)の数が
      task_completions.where(task: homework.tasks).count
      # 完了したタスクの中にある、ユーザーが完了した宿題のtaskの数と等しいかどうか判定。
  end
end

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :classroom
  has_many :task_completions, dependent: :destroy
  
  def completed?(task)
    task_completions.exists?(task: task)
  end
end

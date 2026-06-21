class Admin::ClassroomsController < Admin::BaseController
  def index
    @classrooms = Classroom.all
  end
end

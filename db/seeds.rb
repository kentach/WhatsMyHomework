VocabularyTest.delete_all
TaskCompletion.delete_all
Task.delete_all
Homework.delete_all
NotificationClassroom.delete_all
Notification.delete_all
User.delete_all
Classroom.delete_all

classrooms = [
  [ 'TOEIC', 'Toeic' ],
  [ '準1級', 'Pre1' ],
  [ '2級', 'STEP2' ],
  [ '準2級プラス', 'Pre2 plus' ],
  [ '準2級', 'Pre2' ],
  [ '中学生3級', 'JH1 STEP3' ],
  [ '中学生4級', 'JH1 STEP4' ],
  [ '中学生5級', 'JH1 Beginner' ],
  [ '小学生2級', 'EH STEP2' ],
  [ '小学生準2プラス', 'EH Pre2 plus' ],
  [ '小学生準2級', 'EH pre2' ],
  [ '小学生3級', 'EH3' ],
  [ '小学生高学年4級', 'EH4' ],
  [ '小学生低学年4級', 'EL4' ],
  [ '小学生高学年5級', 'EH5' ],
  [ '小学生低学年5級', 'EL5' ]
]

created_classrooms = classrooms.map do |name, level|
  Classroom.create!(
    eiken_level: level,
    name: name
  )
end

user1 = User.create!(
  name: "上拾石",
  student_id: "kenta555",
  password: "kenta555",
  password_confirmation: "kenta555",
  classroom: created_classrooms.find { |class| class.name == "準1級" }
  role: 1
)

user2 = User.create!(
  name: "大川",
  student_id: "kotaro555",
  password: "kotaro555",
  password_confirmation: "kotaro555",
  classroom: created_classrooms.find { |class| class.name == "2級" }
  role: 1
)

user3 = User.create!(
  name: "片山",
  student_id: "daiki555",
  password: "daiki555",
  password_confirmation: "daiki555",
  classroom: created_classrooms.find { |class| class.name == "準2級" }
  role: 1
)

user4 = User.create!(
  name: "矢野",
  student_id: "tsubasa555",
  password: "tsubasa555",
  password_confirmation: "tsubasa555",
  classroom: created_classrooms.find { |class| class.name == "準2級プラス" }
  role: 1
)

user5 = User.create!(
  name: "宮田",
  student_id: "suzuka555",
  password: "suzuka555",
  password_confirmation: "suzuka555",
  classroom: created_classrooms.find { |class| class.name == "中学生3級" }
  role: 1
)

user5 = User.create!(
  name: "大塚",
  student_id: "mitsuki555",
  password: "mitsuki555",
  password_confirmation: "mitsuki555",
  classroom: created_classrooms.find { |class| class.name == "小学生高学年5級" }
  role: 1
)

user6 = User.create!(
  name: "稲荷",
  student_id: "hinako555",
  password: "hinako555",
  password_confirmation: "hinako555",
  classroom: created_classrooms.find { |class| class.name == "小学生高学年4級" }
  role: 1
)

end

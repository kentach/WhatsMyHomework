VocabularyTest.delete_all
TaskCompletion.delete_all
Task.delete_all
Homework.delete_all
NotificationClassroom.delete_all
Notification.delete_all
User.delete_all
Classroom.delete_all

classrooms = [
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
  name: "片山",
  student_id: "saitama3181",
  password: "saitama3181",
  password_confirmation: "saitama3181",
  classroom: created_classrooms.first,
  role: 1
)

task_templates = [
  "単語テスト",
  "音読10回",
  "英作文提出",
  "長文問題",
  "リスニング演習"
]

created_classrooms.each do |classroom|
  4.times do |week|
    homework = classroom.homeworks.create!(
      title: "#{classroom.name} Week#{week + 1}",
      test_start_date: Date.today + week.weeks,
      test_end_date: Date.today + week.weeks + 6.days,
      user_id: user1.id,
      status: "published"
    )

    task_templates.each do |task_name|
      homework.tasks.create!(
        name: "#{task_name} #{week + 1}"
      )
    end
  end
end

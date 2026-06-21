VocabularyTest.delete_all
TaskCompletion.delete_all
Task.delete_all
Homework.delete_all
User.delete_all
Classroom.delete_all

classrooms = [
  [ 'Pre1', '準1級' ],
  [ 'STEP2', '2級' ],
  [ 'Pre2 plus', '準2級プラス' ],
  [ 'Pre2', '準2級' ],
  [ 'JH1 STEP3', '中学生3級' ],
  [ 'JH1 STEP4', '中学生4級' ],
  [ 'JH1 Beginner', '中学生5級' ],
  [ 'EH STEP2', '小学生2級' ],
  [ 'EH Pre2 plus', '小学生準2級プラス' ],
  [ 'EH pre2', '小学生準2級' ],
  [ 'EH3', '小学生3級' ],
  [ 'EH4', '小学生高学年4級' ],
  [ 'EL4', '小学生低学年4級' ],
  [ 'EH5', '小学生高学年5級' ],
  [ 'EL5', '小学生低学年5級' ]
]

created_classrooms = classrooms.map do |name, level|
  Classroom.create!(
    name: name,
    eiken_level: level
  )
end

user1 = User.create!(
  name: "片山",
  email: "saitama3181@example.com",
  password: "saitama3181",
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
      title: "#{classroom.eiken_level} Week#{week + 1}",
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

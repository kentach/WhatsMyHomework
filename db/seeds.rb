Task.delete_all
Homework.delete_all
Classroom.delete_all
User.delete_all

user1 = User.create!(
  name: "片山",
  email: "saitama3181@example.com",
  password: "saitama3181"
)

pre1 = Classroom.create!(
  name: 'Pre1',
  eiken_level: '準1級'
)

# Pre1の宿題
pre1_week30 = pre1.homeworks.create!(
  title: '準1級 Week30 宿題',
  test_start_date: Date.today,
  test_end_date: Date.today + 7.days,
  user_id: user1.id,
  status: "published"
)

pre1_week30.tasks.create!(
  name: 'Week30 単語テスト #1〜60'
)

pre1_week30.tasks.create!(
  name: 'STEP TALK p.32 Writingの賛成意見を書いて提出。'
)

pre1_week30.tasks.create!(
  name: 'STEP Power p23の一段落目を音読 最低10回'
)

step2 = Classroom.create!(
  name: 'STEP2',
  eiken_level: '2級'
)

step2_week30 = step2.homeworks.create!(
  title: '2級 Week30 宿題',
  test_start_date: Date.today,
  test_end_date: Date.today + 7.days,
  user_id: user1.id,
  status: "published"
)


step2_week30.tasks.create!(
  name: 'Week30 単語テスト #1~50',
)

step2_week30.tasks.create!(
  name: 'STEP TALK p.34 賛成意見を書いて提出。',
)


# 以下クラスのみ作成
Classroom.create!(name: 'Pre2 plus', eiken_level: '準2級プラス')
Classroom.create!(name: 'Pre2', eiken_level: '準2級')
Classroom.create!(name: 'JH1 STEP3', eiken_level: '中学生3級')
Classroom.create!(name: 'JH1 STEP4', eiken_level: '中学生4級')
Classroom.create!(name: 'JH1 Beginner', eiken_level: '中学生5級')
Classroom.create!(name: 'EH STEP2', eiken_level: '小学生2級')
Classroom.create!(name: 'EH Pre2 plus', eiken_level: '小学生準2級プラス')
Classroom.create!(name: 'EH pre2', eiken_level: '小学生準2級')
Classroom.create!(name: 'EH3', eiken_level: '小学生3級')
Classroom.create!(name: 'EH4', eiken_level: '小学生高学年4級')
Classroom.create!(name: 'EL4', eiken_level: '小学生低学年4級')
Classroom.create!(name: 'EH5', eiken_level: '小学生高学年5級')
Classroom.create!(name: 'EL5', eiken_level: '小学生低学年5級')

# db/seeds/development.rb
# ── 開発環境専用：全削除してテストデータを再生成 ──
# 通知など本番データには一切影響しない

VocabularyTest.delete_all
TaskCompletion.delete_all
Task.delete_all
Homework.delete_all
NotificationClassroom.delete_all
Notification.delete_all
User.delete_all

users = [
  { name: "上拾石",  student_id: "kenta555",   classroom_name: "準1級" },
  { name: "大川",    student_id: "kotaro555",  classroom_name: "2級" },
  { name: "片山",    student_id: "daiki555",   classroom_name: "準2級" },
  { name: "矢野",    student_id: "tsubasa555", classroom_name: "準2級プラス" },
  { name: "宮田",    student_id: "suzuka555",  classroom_name: "中学生3級" },
  { name: "大塚",    student_id: "mitsuki555", classroom_name: "小学生高学年5級" },
  { name: "稲荷",    student_id: "hinako555",  classroom_name: "小学生高学年4級" },
  { name: "ゲスト",  student_id: "guest555",   classroom_name: "小学生3級" }
]

users.each do |attrs|
  User.create!(
    name: attrs[:name],
    student_id: attrs[:student_id],
    password: attrs[:student_id],
    password_confirmation: attrs[:student_id],
    classroom: Classroom.find_by!(name: attrs[:classroom_name]),
    role: 1
  )
end

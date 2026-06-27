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

classrooms.each do |name, level|
  Classroom.find_or_create_by!(eiken_level: level) do |c|
    c.name = name
  end
end

env_seed = Rails.root.join("db/seeds/#{Rails.env}.rb")
load(env_seed) if File.exist?(env_seed)

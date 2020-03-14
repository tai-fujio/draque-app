EMAIL = 'test@example.com'
PASSWORD = 'password'

# テストユーザーが存在しないときだけ作成する
User.find_or_create_by!(email: EMAIL) do |user|
  user.password = PASSWORD
end
system 'rake import_csv:monster_data'
system 'rake import_csv:exp_data'
puts "初期データの投入に成功しました。"
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

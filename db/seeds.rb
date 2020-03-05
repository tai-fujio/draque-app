# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Email = "maru@maru"
Password = "marumaru"

# Email="◯◯"と同じものが同じものがあれば、それを引っ張ってくる。なければ do |user|でそのアドレスで後述のpasswordのアカウント作る。
# さらにそれが作られるとmodels/userの記述で初期値が入るようになっている。
User.find_or_create_by!(email: Email) do |user|
  user.password = Password
end

system "rake import_csv:monster_data"

puts "初期データの投入に成功しました"

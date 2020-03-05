namespace :import_csv do
  desc "monsters data import"
  task monster_data: :environment do
    Monster.destroy_all
    monster_list = Import.csv_info(path: 'db/csv/monsters.csv')
    Monster.create!(monster_list)
    puts 'monsters import complete'
  end
end

# 一度データの中身を全て削除して
# csvデータを読み込んだimportクラスを作成し変数monster_listにインポートし
# 改めてモンスターを作成する。

# Importクラスはアクティブレコードを継承していないので、
# app/modelには入れないほうが良い。
# 別の場所に作成。


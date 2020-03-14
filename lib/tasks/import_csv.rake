namespace :import_csv do
  desc 'モンスターデータをインポートするタスク'
  task monster_data: :environment do
    # データベースのモンスターデータを削除
    Monster.destroy_all
    # 現在のモンスターデータをインポートした配列を作成
    monster_list = Import.csv_data(path: 'db/csv_data/monsters.csv')
    # モンスターデータをデータベースに投入
    Monster.create!(monster_list)
    puts 'モンスターデータの投入に成功しました。'
  end

  desc '経験値テーブルをインポートするタスク'
  task exp_data: :environment do
    ExpTable.destroy_all
    exp_list = Import.csv_data(path: 'db/csv_data/exp_table.csv')
    ExpTable.create!(exp_list)
    puts '経験値テーブルの投入に成功しました。'
  end
end

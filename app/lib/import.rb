require "csv"
# csvファイルを使うときは必要
class Import
  def self.csv_info(path:)
    list = []
    CSV.foreach(path, headers: true){|row| list << row.to_h}
    list
  end
end
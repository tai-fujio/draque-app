class AddWordToBraves < ActiveRecord::Migration[5.2]
  def change
    add_column :braves, :word, :string
  end
end

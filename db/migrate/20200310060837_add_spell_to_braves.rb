class AddSpellToBraves < ActiveRecord::Migration[5.2]
  def change
    add_column :braves, :spell, :string
  end
end

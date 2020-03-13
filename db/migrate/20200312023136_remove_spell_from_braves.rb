class RemoveSpellFromBraves < ActiveRecord::Migration[5.2]
  def change
    remove_column :braves, :spell, :string
  end
end

class RemoveSpellFromGames < ActiveRecord::Migration[5.2]
  def change
    remove_column :games, :spell, :string
  end
end

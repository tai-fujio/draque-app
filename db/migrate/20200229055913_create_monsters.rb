class CreateMonsters < ActiveRecord::Migration[5.2]
  def change
    create_table :monsters do |t|
      t.string :name, null: false, unique: true, index: true
      t.string :image, null: false
      t.integer :recommended_level, null: false
      t.integer :max_hp, null: false
      t.integer :offense, null: false
      t.integer :defense, null: false
      t.integer :exp, null: false

      t.timestamps
    end
  end
end

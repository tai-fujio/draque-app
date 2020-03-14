class CreateBraves < ActiveRecord::Migration[5.2]
  def change
    create_table :braves do |t|
      t.references :user, foreign_key: true
      t.string :name, null: false
      t.integer :level, null: false
      t.bigint :exp, null: false
      t.integer :max_hp, null: false
      t.integer :offense, null: false
      t.integer :defense, null: false

      t.timestamps
    end
  end
end

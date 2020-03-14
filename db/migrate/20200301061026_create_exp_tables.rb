class CreateExpTables < ActiveRecord::Migration[5.2]
  def change
    create_table :exp_tables do |t|
      t.integer :level, null: false, unique: true
      t.bigint :exp, null: false, index: true

      t.timestamps
    end
  end
end

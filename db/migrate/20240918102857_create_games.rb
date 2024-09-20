class CreateGames < ActiveRecord::Migration[7.2]
  def change
    create_table :games do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :rows
      t.integer :columns
      t.text :matrix

      t.timestamps
    end
  end
end

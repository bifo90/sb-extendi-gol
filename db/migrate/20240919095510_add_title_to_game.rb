class AddTitleToGame < ActiveRecord::Migration[7.2]
  def change
    add_column :games, :title, :string
  end
end

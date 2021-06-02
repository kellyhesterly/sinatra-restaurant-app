class AddNameColumnToRestaurantEntriesTable < ActiveRecord::Migration[5.2]
  def change
    add_column :restaurant_entries, :name, :string
  end
end

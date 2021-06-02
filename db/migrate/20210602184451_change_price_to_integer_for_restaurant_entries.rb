class ChangePriceToIntegerForRestaurantEntries < ActiveRecord::Migration[5.2]
  def change
    change_column :restaurant_entries, :price, :integer
  end
end

class CreateRestaurantEntriesTable < ActiveRecord::Migration[4.2]
  def change
    create_table :restaurant_entries do |t|
      t.integer :user_id
      t.string :content
      t.string :dish
      t.string :drink
      t.string :service
      t.string :price
      t.string :atmosphere
    end
  end
end

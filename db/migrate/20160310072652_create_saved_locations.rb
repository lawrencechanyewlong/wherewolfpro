class CreateSavedLocations < ActiveRecord::Migration
  def change
    create_table :saved_locations do |t|
      t.string :name
      t.float :address_lat
      t.float :address_lng
      t.string :uid

      t.timestamps null: false
    end
  end
end

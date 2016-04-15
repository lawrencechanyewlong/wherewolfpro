class AddCurrentlatCurrentlng < ActiveRecord::Migration
  def up
    add_column :events, :current_lat, :float
    add_column :events, :current_lng, :float
  end

  def down
    remove_column :events, :current_lat
    remove_column :events, :current_lng
  end
end

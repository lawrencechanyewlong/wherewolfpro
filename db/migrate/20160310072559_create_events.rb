class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :uid
      t.float :address_lat
      t.float :address_lng
      t.string :receiver
      t.datetime :datetime_sent
      t.string :duration_setting
      t.boolean :active

      t.timestamps null: false
    end
  end
end

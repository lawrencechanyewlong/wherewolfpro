class AddAddressStringToEvents < ActiveRecord::Migration
  def change
    add_column :events, :address_string, :string
  end
end

class AddContactsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :contacts, :string
  end
end

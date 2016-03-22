class AddReceiverNameToEvents < ActiveRecord::Migration
  def change
    add_column :events, :receiver_name, :string
  end
end

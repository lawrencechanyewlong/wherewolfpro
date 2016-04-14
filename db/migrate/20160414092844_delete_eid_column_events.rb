class DeleteEidColumnEvents < ActiveRecord::Migration
  def up
    remove_column :events, :eid
  end

  def down
    add_column :events, :eid, :integer
  end
end

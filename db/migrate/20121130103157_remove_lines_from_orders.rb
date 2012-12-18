class RemoveLinesFromOrders < ActiveRecord::Migration
  def up
    remove_column :orders, :line_id
  end

  def down
    add_column :orders, :line_id, :integer
  end
end

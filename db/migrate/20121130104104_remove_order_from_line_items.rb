class RemoveOrderFromLineItems < ActiveRecord::Migration
  def up
    remove_column :line_items, :order_ind
  end

  def down
    add_column :line_items, :order_ind, :integer
  end
end

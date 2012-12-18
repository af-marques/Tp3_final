class AddConclusionToOrders < ActiveRecord::Migration
  def self.up
    add_column :orders, :conclusion, :date
  end
  def self.down
    remove_column :orders, :conclusion
  end
end

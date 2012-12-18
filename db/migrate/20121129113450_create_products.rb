class CreateProducts < ActiveRecord::Migration
  def self.up
    create_table :products do |t|
      t.string :name
      t.text :description
      t.decimal :price
      t.string :image_url
      t.integer :category_id

      t.timestamps
    end
  end
  def self.down
    drop_table :products
  end
end

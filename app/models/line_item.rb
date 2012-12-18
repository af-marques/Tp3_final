class LineItem < ActiveRecord::Base
  attr_accessible :order_id, :product_id, :quantity, :product
  belongs_to :order , :foreign_key => :order_id
  belongs_to :product , :foreign_key => :product_id

  def line_item_total_price
    product.price * quantity
  end

end


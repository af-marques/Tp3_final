class CombineItemsInOrder < ActiveRecord::Migration
  def up

    # replace multiple items for a single product in a cart with a single item
    Order.all.each do |ord|
      # count the number of each product in the cart
      sums = ord.line_items.group(:product_id,:order_id).sum(:quantity)

      sums.each do |product_id, quantity|
        if quantity > 1
          # remove individual items
          ord.line_items.where(:product_id=>product_id).delete_all

          # replace with a single item
          ord.line_items.create(:product_id=>product_id, :quantity=>quantity)
        end
      end
    end


  end

  def down

    # split items with quantity>1 into multiple items
    LineItem.where("quantity>1").each do |line_item|
      # add individual items
      line_item.quantity.times do
        LineItem.create :order_id=>line_item.order_id,
                        :product_id=>line_item.product_id, :quantity=>1
      end

      # remove original item
      line_item.destroy
    end

  end
end

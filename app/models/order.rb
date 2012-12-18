class Order < ActiveRecord::Base
  attr_accessible :user_id, :conclusion
  belongs_to :user
  has_many :line_items, :dependent => :destroy

  def total_price
    line_items.to_a.sum { |item| item.line_item_total_price }
  end

end

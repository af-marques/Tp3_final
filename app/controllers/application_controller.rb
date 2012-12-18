class ApplicationController < ActionController::Base
  protect_from_forgery

  private

  def current_order
    Order.find(cookies[:order_id])
  rescue ActiveRecord::RecordNotFound
    order = Order.create
    cookies[:order_id] = {
        :value => order.id,
        :expires => 1.year.from_now
    }
    order
  end

end

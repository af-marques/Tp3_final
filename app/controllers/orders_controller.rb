class OrdersController < ApplicationController

  def grouping
    # replace multiple items for a single product in a cart with a single item
    Order.all.each do |ord|
      # count the number of each product in the cart
      sums = ord.line_items.group(:product_id).sum(:quantity)

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


  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.all

    respond_to do |format|
      format.html # index2.html.erb
      format.json { render json: @orders }
    end
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
    @order = Order.find(params[:id])
    @categories = Category.all
    grouping
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @order }
    end
  end

  # GET /orders/new
  # GET /orders/new.json
  def new
    @order = Order.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @order }
    end
  end

  # GET /orders/1/edit
  def edit
    @order = Order.find(params[:id])
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(params[:order])
                                       Anabela17Japan
    respond_to do |format|
      if @order.save
        format.html { redirect_to @order, notice: 'Order was successfully created.' }
        format.json { render json: @order, status: :created, location: @order }
      else
        format.html { render action: "new" }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /orders/1
  # PUT /orders/1.json
  def update
    @order = Order.find(params[:id])

    respond_to do |format|
      if @order.update_attributes(params[:order])
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order = Order.find(params[:id])
    @order.destroy

    respond_to do |format|
      format.html { redirect_to orders_url }
      format.json { head :no_content }
    end
  end

  def conclude
    @order = Order.find(params[:id])

    if @order.conclusion.nil?
      @order.update_attribute( :conclusion , Date.current())
      cookies.delete :order_id
      respond_to do |format|
        format.html { redirect_to root_path , notice: 'Order concluded.' }
      end
    else
      respond_to do |format|
        format.html { redirect_to orders_url, notice: 'You cannot finish a finished order!'}
      end
    end
  end

end

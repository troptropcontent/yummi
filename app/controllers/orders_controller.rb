class OrdersController < ApplicationController
# def new
#   @order = current_order
#   @order.status = "In_progress"
#   @line = Line.new
#   @line.meal = Meal.find(params[:meal])
#   @line.quantity = 1
#   authorize @order
# end

  def show
    @order = Order.find(params[:id] )
    authorize @order
  end

  def update
    @lines=[]
    @linesParams = params.select{|param| param[0]=="l"}
    @linesParams.each do |line|
      @lines << line
    end
    @lines.each do |line|
      updated_line = Line.find(line[0].split("_")[-1])
      updated_line.quantity = line[1]
      updated_line.save!
    end
    @order = Order.find(params[:id])
    @order.delivery_type = params[:order][:delivery_type] 
    @order.delivery_fee_cents = params[:delivery_fee]
    @order.price_cents = @order.total_before_checkout
    @order.status = "Comfirmed"
    @order.save!
    authorize @order

    pay()

  end

  private

  def pay
    
  # Amount in cents
    @user = current_user
    @amount = @order.price_cents
    

    # customer = Stripe::Customer.create({
    #   email: params[:stripeEmail],
    #   source: params[:stripeToken],
    # })

    # charge = Stripe::Charge.create({
    #   customer: customer.id,
    #   amount: @amount,
    #   description: 'Rails Stripe customer',
    #   currency: 'eur',
    # })

    # Chatroom.create(order_id: @order.id, user_id: @user.id, cook_id: @order.lines.first.meal.user.id)
    session[:order_id] = nil
    @order.status = "Paid"
    @order.save!
    redirect_to dashboard_path
    


  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to @order
  end


end

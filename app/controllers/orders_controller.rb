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
    @order.price_cents = @order.total_before_checkout
    # @order.status = "In_progress"
    @order.save!
    authorize @order
    redirect_to @order
  end

  private

  def pay
  # Amount in cents
    @order = Order.find(params[:OrderId])
    @user = current_user
    @amount = @order.total_before_checkout

    customer = Stripe::Customer.create({
      email: params[:stripeEmail],
      source: params[:stripeToken],
    })

    charge = Stripe::Charge.create({
      customer: customer.id,
      amount: @amount,
      description: 'Rails Stripe customer',
      currency: 'eur',
    })

    Chatroom.create(order_id: @order.id, user_id: @user.id, cook_id: @order.lines.first.meal.user.id)
    session[:order_id] = nil
    redirect_to dashboard_path
    @order.status = "Paid"


  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end


  def order_params
    params.require(:order).permit(:status, :price_cents, :user_id)
  end


end

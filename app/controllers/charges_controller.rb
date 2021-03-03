class ChargesController < ApplicationController

  def new
  end

  def create
    raise
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

    # Chatroom.create(order_id: @order.id, user_id: @user.id, cook_id: @order.lines.first.meal.user.id)
    session[:order_id] = nil
    redirect_to dashboard_path
    @order.status = "Paid"


  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end

end

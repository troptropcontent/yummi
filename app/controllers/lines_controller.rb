class LinesController < ApplicationController

  def create

    @line = Line.new
    @line.order = current_order
    @line.quantity = 1
    @line.meal = Meal.find(params[:line][:meal])
    @line.save!

    # @line user order meal
    # line.order = current_order
    # sauver la ligne dans
    # @order = current_user
    authorize @line
    redirect_to @line.order
  end

  private

  def current_order
    if session[:order_id] && Order.find_by(id: session[:order_id])
      Order.find(session[:order_id])
    else
      order = Order.create!(user: current_user, status: "In_progress")
      session[:order_id] = order.id
      order
    end
  end
end

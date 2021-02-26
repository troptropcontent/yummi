class OrdersController < ApplicationController
def new
  @order = current_order
  @line = Line.new
  @line.meal = Meal.find(params[:meal])
  @line.quantity = 1
  authorize @order
end

  def show
    @order = Order.find(params[:id] )
    authorize @order
  end
  
  def update
    raise
    @order = Order.find(params[:id])
    @order.status = "Confirmed"
    authorize @order
  end
  
end

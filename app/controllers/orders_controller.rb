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
    @order.status = "Confirmed"
    @order.save!
    authorize @order
  end


  def order_params
    params.require(:order).permit(:status, :price_cents, :user_id)
  end
  
  
end

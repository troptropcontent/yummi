class LinesController < ApplicationController

  def create
    @line = Line.new
    @line.order = current_order
    @line.quantity = 1
    @line.meal = Meal.find(params[:line][:meal])
    @line.save!
    
    other_lines_to_add = params.select{|param,value| param[0,10]=="other_meal" && value == "1"}
    # ajout des other_lines
    if other_lines_to_add.keys.length > 0
      other_lines = []
      other_lines_params = other_lines_to_add
      other_lines_params.each do |other_line|
        other_line_to_add = Line.new
        other_line_to_add.order = current_order
        other_line_to_add.meal = Meal.find(other_line[0].split("_")[-1])
        other_line_to_add.quantity = 1
        other_line_to_add.save!
      end 
    end
    
    # @line user order meal
    # line.order = current_order
    # sauver la ligne dans
    # @order = current_user
    authorize @line
    redirect_to @line.order
  end

  private

  def current_order
    if session[:order_id] && Order.find_by(id: session[:order_id]) && Order.find_by(id: session[:order_id]).user == current_user
      Order.find(session[:order_id])
    else
      order = Order.create!(user: current_user, status: "In_progress")
      session[:order_id] = order.id
      order
    end
  end
end

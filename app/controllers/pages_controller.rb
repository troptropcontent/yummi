class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    @meals = Meal.all.sample(5)
  end

  def dashboard
    @user = current_user
    @orders = @user.orders.select{|order| order.status }
    @meal = Meal.find(1)
  end
end

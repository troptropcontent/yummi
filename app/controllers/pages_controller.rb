class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home, :homepage ]

  def home
    @meals = Meal.all.sample(5)
  end

  def dashboard
    @user = current_user
    @review = Review.new
    @orders = @user.orders.select{|order| order.status }
    @meal = Meal.find(1)
  end

  def settings

  end

  def homepage
  end

end

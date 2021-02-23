class MealsController < ApplicationController
  def index
    @meals = Meal.all
  end

  def show
    @meal = Meal.find(params[:id])
  end

  def new
    @meal = Meal.new
  end

  def create
    @meal = Meal.new(meal_params)
    if @meal.save
      redirect_to meal_path(@meal)
    else
      render :new
    end
  end

  def edit
    @meal = meal.find(params[:id])
  end

   def update
    @meal = meal.find(params[:id])
    @meal.update(meal_params)
    redirect_to meal_path(@meal)
  end

  def destroy
    @meal = meal.find(params[:id])
    @meal.destroy
    redirect_to meals_path
  end

   private

  def meal_params
    params.require(:meal).permit(:id, :name, :description, :cuisine, :user_id, :price_cents, :discount)
  end
end

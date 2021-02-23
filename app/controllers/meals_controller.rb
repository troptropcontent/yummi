class MealsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show, :filter]

  def index
    @meals = policy_scope(Meal).order(created_at: :desc)
    if params[:query].present?
      sql_query = " \ meals.name @@ :query "
      @meals = Meal.where(sql_query, query: "%#{params[:query]}%")
    else
      @meals = Meal.all
    end
  end

  def show
    @meal = Meal.find(params[:id])
  end

  def new
    @meal = Meal.new
    authorize @meal
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

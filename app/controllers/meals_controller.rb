class MealsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show, :filter]

  def index
    @meals = policy_scope(Meal).order(created_at: :desc)
    @meals = Meal.all

    if params[:query].present?
      sql_query = " \ meals.name @@ :query OR \
      meals.cuisine @@ :query OR \
      users.first_name @@ :query OR \
      users.last_name @@ :query \ "
      @meals = @meals.joins(:user).where(sql_query, query: "%#{params[:query]}%")
    end

    if params[:chef].present?
      sql_chef = " \ meals.user_id.first_name @@ :chef "
      @meals = @meals.where(sql_chef, chef: "%#{params[:chef]}%")
    end

    if params[:cuisine].present?
      sql_query = " \ meals.cuisine @@ :cuisine "
      @meals = @meals.where(sql_query, cuisine: "%#{params[:cuisine]}%")
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

  private

  def meal_params
    params.require(:meal).permit(:name, :description, :cuisine, :user_id, :price_cents, :discount)
  end
end

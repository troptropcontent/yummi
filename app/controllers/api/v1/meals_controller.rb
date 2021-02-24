class Api::V1::MealsController < Api::V1::BaseController
  acts_as_token_authentication_handler_for User, except: [ :index, :show ]
  before_action :set_meal, only: [ :show, :update, :destroy ]

  def index
    @meals = policy_scope(Meal)
  end

  def show
  end

  def update
    if @meal.update(meal_params)
      render :show
    else
      render_error
    end
  end

  def create
    @meal = Meal.new(meal_params)
    @meal.user = current_user
    authorize @meal
    if @meal.save
      render :show, status: :created
    else
      render_error
    end
  end

  def destroy
    @meal.destroy
    head :no_content
    # No need to create a `destroy.json.jbuilder` view
  end

  private

  def meal_params
    params.require(:meal).permit(:id, :name, :description, :speciality, :user_id, :price_cents, :discount)
  end

  def render_error
    render json: { errors: @meal.errors.full_messages },
      status: :unprocessable_entity
  end

  def set_meal
    @meal = Meal.find(params[:id])
    authorize @meal  # For Pundit
  end
end

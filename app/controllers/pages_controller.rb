class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    @meals = Meal.all.sample(5)
  end
end

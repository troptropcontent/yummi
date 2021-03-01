class ReviewsController < ApplicationController
  def create
    @rating = Review::RATING
    @review = Review.new(review_params)
    authorize @review
    @review.order_id = params["order_id"]
    @review.user = current_user
    if @review.save!
      redirect_to dashboard_path
    else
      redirect_to dashboard_path
    end
  end

  private

  def review_params
    params.require(:review).permit(:rating, :content)
  end
end

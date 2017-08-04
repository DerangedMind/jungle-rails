class ReviewsController < ApplicationController

  before_action :authorize

  def create
    @product = Product.find(params[:product_id])
    @review = Review.new(review_params)
    @review.product_id = @product.id
    @review.user = current_user

    if @review.save
      redirect_to '/products/'+@product.id.to_s
    end
  end

  private

  def review_params
    params.require(:review).permit(
      :rating,
      :description
    )
  end

end

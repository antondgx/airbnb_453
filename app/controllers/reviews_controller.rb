class ReviewsController < ApplicationController
  before_action :find_property
  skip_before_action :authenticate_user!, only: [:index, :show]
  def new 
    @review = Review.new 
    authorize @review
  end 

  def create
    @review = Review.new(review_params)
    @review.user = current_user
    @review.property = @property
    authorize @review
    if @review.save 
      redirect_to property_path(@property)
    else
      flash[:alert] = "Something went wrong."
      render :new
    end 
  end

  private

  def find_property
    @property = Property.find(params[:property_id])
  end

  def review_params 
    params.require(:review).permit(:content, :rating)
  end 
end

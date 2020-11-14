class PropertiesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :set_property, only: [:show, :edit, :update, :destroy]

  def index
    # @properties = Property.all
    # @properties = policy_scope(Property).order(created_at: :desc)
    if params[:query].present?
      @properties = policy_scope(Property).search_by_title_description_and_address(params[:query])
    else
      @properties = policy_scope(Property).order(created_at: :desc)
    end

    @markers = @properties.map do |property|
      {
        lat: property.latitude,
        lng: property.longitude,
        # infoWindow: { content: render_to_string(partial: "info_window", locals: { property: property }) }
      }
    end
  end

  def show
    @property = Property.find(params[:id])
    @booking = Booking.new
    @markers = [{ lat: @property.latitude, lng: @property.longitude }]
  end

  def new
    @property = Property.new
    authorize @property
  end

  def create
    @property = Property.new(property_params)
    @user = User.find(current_user.id)
    @property.user = @user
    authorize @property

    if @property.save
      redirect_to property_path(@property)
    else
      render :new
    end
  end

  def edit
  end

  def update
    @property.update(property_params)
    redirect_to property_path(@property)
  end

  def destroy
    @property.destroy
    redirect_to properties_path
  end

  private

  def set_property
    @property = Property.find(params[:id])
    authorize @property
  end

  def property_params
    params.require(:property).permit(:title, :description, :address, :price, :capacity, photos: [])
  end
end

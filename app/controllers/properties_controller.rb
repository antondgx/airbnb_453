class PropertiesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    @properties = Property.all
    authorize @properties

  end

  def show
    @property = Property.find(params[:id])
    authorize @property

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
    @property = Property.find(params[:id])
  end

  def update
    @property = Property.find(params[:id])
    @property.update(property_params)
    redirect_to property_path(@property)
  end

  def destroy
    @property = Property.find(params[:id])
    @property.destroy
    redirect_to properties_path
  end

  private

  def property_params
    params.require(:property).permit(:title, :description, :address, :price, :capacity, photos: [])
  end
end

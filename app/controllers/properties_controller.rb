class PropertiesController < ApplicationController
  def index
    @properties = Property.all
  end

  def show
    @property = Property.find(params[:id])
  end

  def new
    @property = Property.new
  end

  def create
    @property = Property.new(property_params)
    @user = User.find(current_user.id)
    @property.user = @user
    @property.save
    redirect_to property_path(@property)
  end

  def edit
    @property = Property.find(params[:id])
  end

  def update
    @property = Property.find(params[:id])
    @propety.update(property_params)
    redirect_to property_path(@property)
  end

  def destroy
    @property = Property.find(params[:id])
    @property.destroy
    redirect_to properties_path
  end

  private

  def property_params
    params.require(:property).permit(:title, :descripton, :address, :price, :capacity)
  end
end

class PropertiesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :set_property, only: [:show, :edit, :update, :destroy]

  def index
    # @properties = Property.all
    @properties = policy_scope(Property)
  end

  def show
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

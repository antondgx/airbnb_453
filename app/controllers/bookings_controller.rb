class BookingsController < ApplicationController

  # renter action
  def renter_details
    @bookings = current_user.bookings
  end

  # renter action
  def create
    @booking = Booking.new(booking_params)
    @booking.user = current_user
    @property = Property.find(params[:property_id])
    @booking.price = @property.price
    @booking.property = @property

    if @booking.save
      redirect_to property_path(@property)
    else
      render :new
    end
  end

  # owner action
  def destroy
    @booking = Booking.find(params[:id])
    @booking.destroy
  end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date)
  end
end

  # resources :bookings, only:[:new, :create, :destroy]
  # get "/bookings", to: "bookings#renter_details"

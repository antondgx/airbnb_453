class BookingsController < ApplicationController

  # owner action
  def renter_details

  end

  # renter action
  def create
    @booking.new(booking_params)
    @booking.user = current_user
    @property =
    @booking.property =
    if @booking.save
      redirect_to bookings
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
    params.require(:booking).permit(:start_time, :end_time, :price)
  end
end

  # resources :bookings, only:[:new, :create, :destroy]
  # get "/bookings", to: "bookings#renter_details"

class BookingsController < ApplicationController
  # renter action
  def my_bookings
    @bookings = current_user.bookings
  end

  # owner action
  def bookings_on_my_properties
    @my_properties = current_user.properties
  end

  # renter action
  def create
    @booking = Booking.new(booking_params)
    @booking.user = current_user
    @property = Property.find(params[:property_id])
    @booking.price = @property.price
    @booking.property = @property

    if @booking.save
      redirect_to my_bookings_path
    else
      render :new
    end
  end

  # renter action
  def destroy
    @booking = Booking.find(params[:id])
    @booking.destroy
    redirect_to my_bookings_path
  end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date)
  end
end

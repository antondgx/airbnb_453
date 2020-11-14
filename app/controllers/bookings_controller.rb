class BookingsController < ApplicationController
  # renter action
  def my_bookings
    @bookings = current_user.bookings.order(start_date: :asc)
    authorize @bookings
  end

  # owner action
  def bookings_on_my_properties
    @my_properties = current_user.properties
    authorize @my_properties
  end

  # renter action
  def create
    @booking = Booking.new(booking_params)
    @booking.user = current_user
    @property = Property.find(params[:property_id])
    @booking.price = booking_price(@booking, @property)
    # @booking.price = @property.price
    @booking.property = @property
    if @booking.save
      redirect_to my_bookings_path
    else
      redirect_to property_path(@property)
    end

    authorize @booking
    authorize @property
  end

  # renter action
  def destroy
    @booking = Booking.find(params[:id])
    @booking.destroy
    redirect_to my_bookings_path
    authorize @booking
  end

  private

  def booking_price(booking, property)
    if booking.end_date && booking.start_date
      duration = booking.end_date - booking.start_date
      price = property.price * duration
    end
  end

  def booking_params
    params.require(:booking).permit(:start_date, :end_date)
  end
end

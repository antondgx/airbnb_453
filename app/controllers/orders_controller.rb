class OrdersController < ApplicationController
  def create
    property = Property.find(params[:property_id])
    order = Order.create!(property: property, property_title: property.title, amount: property.price, state: 'pending', user: current_user)

    session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: [{
        name: property.title,
        #images: [property.photo_url],
        amount: property.price_cents,
        currency: 'usd',
        quantity: 1
      }],
      success_url: order_url(order),
      cancel_url: order_url(order)
    )

    order.update(checkout_session_id: session.id)
    redirect_to new_order_payment_path(order)
    authorize order
  end

  def show
   @order = current_user.orders.find(params[:id])
   authorize @order
  end

  def destroy
    @order = current_user.orders.find(params[:id])
    authorize @order
    redirect_to properties_path
  end 
  
end

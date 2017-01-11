require_dependency "booking/application_controller"

module Booking
  class ChargesController < ApplicationController
    def new
    end

    def create
      # Set your secret key: remember to change this to your live secret key in production
      # See your keys here: https://dashboard.stripe.com/account/apikeys
      Stripe.api_key = "sk_test_SrBiIo9w1vT3cYoTXnbZFi6V"

      # Get the credit card details submitted by the form
      token = params[:stripeToken]

      # Create a Customer
      customer = Stripe::Customer.create(
        :source => token,
        :description => "Example customer"
      )
      @amount = params[:amount].to_i
      @amount = (@amount * 100).to_i
      @reservation = Reservation.find(params[:reservation_id])

      # Create a charge: this will charge the user's card
      begin
        charge = Stripe::Charge.create(
          :amount => @amount, # Amount in cents
          :currency => "usd",
          :customer => customer.id,
          :description => "Example charge"
        )

        if (charge["paid"] == true)
          #Mark all as paid
          @reservation = Reservation.find(params[:reservation_id])
          @reservation.service_type_reservations.each do |ser_res|
            ser_res.paid = true
            ser_res.save
          end
        end
      rescue Stripe::CardError => e
        # The card has been declined
        flash[:error] = e.message
        redirect_to charges_path
      end

      #Save the customer ID and other info in a database for later!
    end
  end
end

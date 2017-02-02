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

            if(ser_res.check_out)
              #Create service calendar if it doesnt exist
              check_in = ser_res.check_in.to_date
              check_out = ser_res.check_out.to_date
              (check_in..check_out).each do |d|
                @service_calendar = ServiceCalendar.where(service_type_id: ser_res.service_type_id, date: d).first
                #If a service calendar isn't already created for that date
                if (!@service_calendar)
                  selected_service = ServiceType.find(ser_res.service_type_id)
                  #Check if special availability
                  availability = selected_service.availability || 0
                  special_availability = 0
                  if(selected_service.available_from && selected_service.available_to)
                    if(d >= selected_service.available_from.to_date && d <= selected_service.available_to.to_date)
                      special_availability = selected_service.special_availability
                    end
                  end
                  total_availability = availability + special_availability
                  @service_calendar = ServiceCalendar.create(service_type_id: selected_service.id, day_availability: total_availability, special_availability: special_availability, normal_availability: availability, date: d)
                  @service_calendar.save
                else
                  @service_calendar.day_availability -= 1
                end
              end
            end
          end
          @customer_id = @reservation.customer_id
          ConfirmationMailer.confirmation_email(@customer_id).deliver
        end
      rescue Stripe::CardError => e
        # The card has been declined
        flash[:error] = e.message
        redirect_to charges_path
      end

      #Save the customer ID and other info in a database for later!
      @new_customer = Customer.new
      @new_customer = customer
      #@new_customer.save!
    end
  end
end

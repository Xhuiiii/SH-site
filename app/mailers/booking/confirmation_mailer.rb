module Booking
  class ConfirmationMailer < ApplicationMailer
    default from: "xhuibooking@gmail.com"

    def confirmation_email(customer_id)
      @customer = Customer.find(customer_id)
      mail(to: @customer.email, subject: "Booking confirmation email")
    end
  end
end

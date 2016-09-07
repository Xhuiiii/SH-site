require_dependency "booking/application_controller"

module Booking
  class CustomerReservationsController < ApplicationController
  	def destroy
  		@customer = Customer.find(params[:customer_id])
		@reservation = Reservation.find(params[:reservation_id])
		if @customer.present?
			@cust_res = @customer.customer_reservation
		elsif @reservation.present?
			@cust_res = @reservation.customer_reservation
		end
		if @cust_res.destroy
			redirect_to @customer, notice: 'Reservation was deleted.'
		end
  	end
  end
end
require_dependency "booking/application_controller"

module Booking
  class ServiceTypeReservationsController < ApplicationController
    # def new
    #   @reservation = Reservation.find(params[:reservation_id])
    #   @reservation.service_type_reservations.build
    # end

    # def create
    #   @reservation = Reservation.find(params[:reservation_id])
    #   @service_type_reservation = @reservation.service_type_reservations.build(service_type_reservation_params)
      
    #   if @service_type_reservation.save
    #     redirect_to @reservation, notice: 'Reservation was successfully created.'
    #   end
    # end

    def new 
      if :reservation_id
        @reservation = Reservation.find(params[:reservation_id])
      else
        @reservation = Reservation.new
      end
      @reservation.service_type_reservations.build
    end

  	def destroy
  		@reservation = Reservation.find(params[:reservation_id])
  		@service_res = @reservation.service_type_reservations.find(params[:id])
  		if @service_res.destroy
  			redirect_to @reservation.customer, notice: 'Reservation was deleted.'
  		end
  	end

  	# def service_type_reservation_params
  	# 	params.require(:service_type_reservation).permit(:occupancy, :check_in, :check_out, :date, :service_type_id)
  	# end
  end	
end
require_dependency "booking/application_controller"

module Booking
  class UserReservationsControllerController < ApplicationController
    def destroy
  		@user = User.find(params[:user_id])
		@reservation = Reservation.find(params[:reservation_id])
		if @user.present?
			@user_res = @user.user_reservation
		elsif @reservation.present?
			@user_res = @reservation.user_reservation
		end
		if @user_res.destroy
			redirect_to @user, notice: 'Reservation was deleted.'
		end
  	end
  end
end

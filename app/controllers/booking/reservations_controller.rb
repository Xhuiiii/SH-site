require_dependency "booking/application_controller"

module Booking
  class ReservationsController < ApplicationController
    before_action :get_reservation_value

    def show
      #Show previously added items & add new items to res if just signed in
      @existing_res = @reservation
      if user_signed_in? && current_user.reservation
        @reservation = current_user.reservation
      end
      @reservation.recalculate_price!
    end

    def add
      @reservation.save
      session[:reservation_id] = @reservation.id
      item = ServiceTypeReservation.new

      service_type_id = params[:service_type_reservation][:service_type_id]
      check_in = params[:service_type_reservation][:check_in]
      check_out = params[:service_type_reservation][:check_out]
      time_id = params[:service_type_reservation][:time_id]
      occupancy = params[:service_type_reservation][:occupancy]
      adult = params[:service_type_reservation][:adult]
      child = params[:service_type_reservation][:child]

      #Get time
      if(time_id)
        time = Timeslot.find(time_id).time
        checkinDate = check_in.to_date
        check_in = DateTime.new(checkinDate.year, checkinDate.month, checkinDate.day, time.hour, time.min)
      end

      price = 0
      #Calculate price
      #If only checkin
      if(!check_out && check_in)
        price = getPrice(service_type_id, check_in, time_id)
        #set checkout to be checkin
        check_out = check_in
      else
        till_day = (check_out.to_date - 1.days)
        (check_in.to_date..till_day).each do |d|
          price += getPrice(service_type_id, d, time_id)
        end
      end

      @reservation.service_type_reservations.create(reservation_id: @reservation.id, service_type_id: service_type_id, price: price, check_in: check_in, check_out: check_out, time_id: time_id, time: time, occupancy: occupancy, adult: adult, child: child, paid: false)

      @reservation.recalculate_price!
      if user_signed_in?
        current_user.reservation = @reservation
        current_user.save
      end
      flash[:notice] = "Service added to cart."
      redirect_to reservations_path
    end

    def remove
      item = @reservation.service_type_reservations.find(params[:id])
      item.destroy
      @reservation.recalculate_price!
      flash[:notice] = "Service removed from cart."
      redirect_to reservations_path
    end

    protected

    def get_reservation_value
      if session[:reservation_id].nil?
        @reservation = Reservation.create
        session[:reservation_id] = @reservation.id
        @reservation
      else
        @reservation = Reservation.find(session[:reservation_id])
      end
    end

    private

    #Only allow a trusted parameter "white list" through.
    def reservation_params
      respond_to do |format|
        format.html { params.require(:reservation).permit(:updated_at, :created_at, :total_price, service_type_reservations_attributes: [:id, :occupancy, :check_in, :check_out, :date, :time, :adult, :child, :service_type_id, :_destroy])}
        format.json { params.permit(:reservation, :id, :updated_at, :created_at, :total_price, :occupancy, :check_in, :check_out, :date, :service_type_id) }
      end
    end

  end
end

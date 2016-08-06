require_dependency "booking/application_controller"

module Booking
  class ReservationsController < ApplicationController
    before_action :set_reservation, only: [:show, :edit, :update, :destroy]

    # GET /reservations
    def index
      @reservations = Reservation.all
    end

    # GET /reservations/1
    def show
      @reservation = Reservation.includes(:service_types).find(params[:id])
      @hasCustomer = @reservation.customer != nil
    end

    # GET /reservations/new
    def new
      @reservation = Reservation.new
    end

    # GET /reservations/1/edit
    def edit
      @serviceTypes = ServiceType.all
    end

    # POST /reservations
    def create
      @reservation = Reservation.new(reservation_params)
      setReservationPrice(@reservation)

      if @reservation.save
        redirect_to new_customer_path(reservation_id: @reservation.id), notice: 'Reservation was successfully created.'
      else
        render :new
      end
    end

    # PATCH/PUT /reservations/1
    def update
      if @reservation.update(reservation_params)
        setReservationPrice(@reservation)
        if @reservation.save
          redirect_to @reservation, notice: 'Reservation was successfully updated.'
        end
      else
        render :edit
      end
    end

    # DELETE /reservations/1
    def destroy
      @reservation = Reservation.find(params[:id])
      if @reservation.destroy
      #@reservation.destroy
        redirect_to reservations_url, notice: 'Reservation was successfully destroyed.'
      end
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_reservation
        @reservation = Reservation.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def reservation_params
        params.require(:reservation).permit(:total_price, :occupancy, :check_in, :check_out, :date, :time, :customer_id, :service_type_ids => [])
      end

      def getPrice(service, date)
        #set special to not valid
        from_valid = false
        to_valid = false

        #if there is a valid start date
        if(service.available_from)
          if (service.available_from <= date)
            from_valid = true
          end
        end

        # if there is a valid end date
        if(service.available_to)
          if(service.available_to >= date)
            to_valid = true
          end
        end

        #if not valid and there's a default price
        if (( !from_valid || !to_valid ) && service.default_price) || !service.special_price
          return service.default_price
        elsif (from_valid || to_valid) && service.special_price
          return service.special_price
        end
      end

      def setReservationPrice(reservation)
        reservation.total_price = 0

        start_date = reservation.check_in
        end_date = reservation.check_out

        (start_date..end_date).each do |day|
          reservation.service_types.each do |service|
            reservation.total_price += getPrice(service, day)
          end
        end
      end
  end
end


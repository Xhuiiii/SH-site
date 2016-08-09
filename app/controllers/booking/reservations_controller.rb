require_dependency "booking/application_controller"

module Booking
  class ReservationsController < ApplicationController
    before_action :set_reservation, only: [:show, :edit, :update, :destroy]
    respond_to :html, :json

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
      @serviceTypes = ServiceType.all
      @reservation = Reservation.new
      @numberOfServices = @serviceTypes.length
    end

    # GET /reservations/1/edit
    def edit
      @serviceTypes = ServiceType.all
      @numberOfServices = @serviceTypes.length
    end

    # POST /reservations
    def create
      @serviceTypes = ServiceType.all
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
      respond_to do |format|
        if @reservation.update(reservation_params)
            setReservationPrice(@reservation)
              if @reservation.save
                format.json { redirect_to service_calendars_path }
                format.html { redirect_to @reservation, notice: 'Reservation was successfully updated.' }
              end
        else
          render :edit
        end
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
        respond_to do |format|
          format.html { params.require(:reservation).permit(:id, :updated_at, :created_at, :total_price, :occupancy, :check_in, :check_out, :date, :customer_id, :type_id)}
          format.json { params.permit(:reservation, :id, :updated_at, :created_at, :total_price, :occupancy, :check_in, :check_out, :date, :customer_id, :service_type_id) }
        end
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
        #Set dates
        setDates(reservation)
        #Reset price
        reservation.total_price = 0

        start_date = reservation.check_in.to_datetime
        end_date = reservation.check_out.to_datetime

        (start_date..end_date).each do |day|
          reservation.service_types.each do |service|
            reservation.total_price += getPrice(service, day)
          end
        end
      end

      def setDates(reservation)
        reservation.service_types.each do |service|
          #There is only one date
          if (!service.multiple_day)
            reservation.check_in = reservation.date
            reservation.check_out = reservation.date + service.duration.hours
          end
        end
      end
  end
end


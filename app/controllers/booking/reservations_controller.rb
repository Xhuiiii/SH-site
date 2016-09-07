require_dependency "booking/application_controller"

module Booking
  class ReservationsController < ApplicationController
    before_action :set_reservation, only: [:show, :edit, :update, :destroy]
    respond_to :html, :json

    # GET /reservations
    def index
      @reservations = Reservation.all
      @reservations.each do |reservation|
        setReservationPrice(reservation)
      end
    end

    # GET /reservations/1
    def show
      @single_reservations = @reservation.service_type_reservations.all
      setReservationPrice(@reservation)
      @hasCustomer = @reservation.customer != nil
    end

    # GET /reservations/new
    def new
      @serviceTypes = ServiceType.all
      @reservation = Reservation.new
      @reservation.service_type_reservations.build
      @reservation.build_customer_reservation
      @numberOfServices = @serviceTypes.length

      if params[:customer_id]
        @cust_id = params[:customer_id]
      end

      if params[:service_type_id]
        @selectedService = ServiceType.find(params[:service_type_id])
      end

    end

    # GET /reservations/1/edit
    def edit
      @serviceTypes = ServiceType.all
      @numberOfServices = @serviceTypes.length
      @single_reservation = @reservation.service_type_reservations.find(params[:single_service_reservation_id])
      @selectedService = ServiceType.find(@single_reservation.service_type_id)
    end

    # POST /reservations
    def create
      @serviceTypes = ServiceType.all
      @reservation = Reservation.new(reservation_params)

      if @reservation.save
        if (!@reservation.customer.present?)
          redirect_to new_customer_path(reservation_id: @reservation.id), notice: 'Reservation was successfully created.'
        else
          redirect_to @reservation.customer
        end
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
          format.html { params.require(:reservation).permit(:updated_at, :created_at, :total_price, customer_reservation_attributes: [:customer_id], service_type_reservations_attributes: [:id, :occupancy, :check_in, :check_out, :date, :service_type_id, :_destroy])}
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

        reservation.service_type_reservations.each do |service_res|
          service_res.single_res_price = 0
          start_date = service_res.check_in.to_date
          end_date = service_res.check_out.to_date

          (start_date..end_date).each do |day|
            reservation.service_types.each do |service|
              reservation.total_price += getPrice(service, day)
              service_res.single_res_price += getPrice(service, day)
            end
          end
        end
      end

      def setDates(reservation)
        #For each service reservation
        reservation.service_type_reservations.each do |service_res|
          #There is only one date
          my_service = ServiceType.find(service_res.service_type_id)
          if (!my_service.multiple_day)
            service_res.check_in = service_res.date
            service_res.check_out = service_res.date + my_service.duration.hours
          end
        end
      end
  end
end

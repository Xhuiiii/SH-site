require_dependency "booking/application_controller"

module Booking
  class TodaysBookingsController < ApplicationController
    before_action :set_todays_booking, only: [:show, :edit, :update, :destroy]
    has_many :service_types, :customers, :reservations

    # GET /todays_bookings
    def index
      @todays_bookings = TodaysBooking.all
    end

    # GET /todays_bookings/1
    def show
    end

    # GET /todays_bookings/new
    def new
      @todays_booking = TodaysBooking.new
    end

    # GET /todays_bookings/1/edit
    def edit
    end

    # POST /todays_bookings
    def create
      @todays_booking = TodaysBooking.new(todays_booking_params)

      if @todays_booking.save
        redirect_to @todays_booking, notice: 'Todays booking was successfully created.'
      else
        render :new
      end
    end

    # PATCH/PUT /todays_bookings/1
    def update
      if @todays_booking.update(todays_booking_params)
        redirect_to @todays_booking, notice: 'Todays booking was successfully updated.'
      else
        render :edit
      end
    end

    # DELETE /todays_bookings/1
    def destroy
      @todays_booking.destroy
      redirect_to todays_bookings_url, notice: 'Todays booking was successfully destroyed.'
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_todays_booking
        @todays_booking = TodaysBooking.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def todays_booking_params
        params.require(:todays_booking).permit(:date, :service_type_ID, :reservation_ID, :customer_ID, :rate)
      end
  end
end

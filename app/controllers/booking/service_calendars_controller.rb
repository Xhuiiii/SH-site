require_dependency "booking/application_controller"

module Booking
  class ServiceCalendarsController < ApplicationController
    before_action :set_service_calendar, only: [:show, :edit, :update, :destroy]

    # GET /service_calendars
    def index
      @service_calendars = ServiceCalendar.all
      @service_type_reservations = ServiceTypeReservation.all
    end

    # GET /service_calendars/1
    def show
      @service = ServiceCalendar.find(params[:service_type_ID])
    end

    # GET /service_calendars/1/edit
    def edit
    end

    # POST /service_calendars
    def create
      @service_calendar = ServiceCalendar.new(service_calendar_params)

      if @service_calendar.save
        redirect_to @service_calendar, notice: 'Service calendar was successfully created.'
      else
        render :new
      end
    end

    # PATCH/PUT /service_calendars/1
    def update
      if @service_calendar.update(service_calendar_params)
        redirect_to @service_calendar, notice: 'Service calendar was successfully updated.'
      else
        render :edit
      end
    end

    # DELETE /service_calendars/1
    def destroy
      @service_calendar.destroy
      redirect_to service_calendars_url, notice: 'Service calendar was successfully destroyed.'
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_service_calendar
        @service_calendar = ServiceCalendar.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def service_calendar_params
        params.require(:service_calendar).permit(:service_type_ID, :availability, :reservation, :rate, :date)
      end
  end
end

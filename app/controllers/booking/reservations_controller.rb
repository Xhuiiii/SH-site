require_dependency "booking/application_controller"

module Booking
  class ReservationsController < ApplicationController
    before_action :set_reservation, only: [:show, :edit, :update, :destroy]
    has_many :service_types, :customers

    # GET /reservations
    def index
      @reservations = Reservation.all
    end

    # GET /reservations/1
    def show
      
    end

    # GET /reservations/new
    def new
      @reservation = Reservation.new
    end

    # GET /reservations/1/edit
    def edit
      
    end

    # POST /reservations
    def create
      @reservation = Reservation.new(reservation_params)

      if @reservation.save
        redirect_to @reservation, notice: 'Reservation was successfully created.'
      else
        render :new
      end
    end

    # PATCH/PUT /reservations/1
    def update
      if @reservation.update(reservation_params)
        redirect_to @reservation, notice: 'Reservation was successfully updated.'
      else
        render :edit
      end
    end

    # DELETE /reservations/1
    def destroy
      @reservation.destroy
      redirect_to reservations_url, notice: 'Reservation was successfully destroyed.'
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_reservation
        @reservation = Reservation.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def reservation_params
        params.require(:reservation).permit(:reservation_ID, :total_price, :occupancy, :check_in, :check_out, :date, :customer_ID)
      end
  end
end

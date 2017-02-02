require_dependency "booking/application_controller"

module Booking
  class CustomersController < ApplicationController
    before_action :set_customer, only: [:show, :edit, :update, :destroy]
    before_action :get_customer, only: [:new]

    # GET /customers
    def index
      @customers = Customer.all
    end

    # GET /customers/1
    def show
      @reservation = @customer.reservation
      if @customer.reservation
        @single_reservations = @customer.reservation.service_type_reservations.all
      end
    end

    # GET /customers/new
    def new
      @reservation = Reservation.find(params[:reservation_id])
      @customer = Customer.new(title: 1)
      @reservation.customer = @customer
    end

    # GET /customers/1/edit
    def edit
    end

    # POST /customers
    def create
      @reservation = Reservation.find(params[:reservation_id])
      @customer = Customer.new(customer_params)
      @reservation.customer = @customer
      if @reservation.customer.save
        session[:customer_id] = @customer.id
        redirect_to new_charge_path(amount: @reservation.total_price, reservation_id: @reservation.id)
      else
        render :new
      end
    end

    # PATCH/PUT /customers/1
    def update
      if @customer.update(customer_params)
        session[:customer_id] = @customer.id
        @reservation = Reservation.find(@customer.reservation.id)
        redirect_to new_charge_path(amount: @reservation.total_price, reservation_id: @reservation.id)
      else
        render :edit
      end
    end

    # DELETE /customers/1
    def destroy
      @customer.destroy
      redirect_to customers_url, notice: 'Customer was successfully destroyed.'
    end


    private
      # Use callbacks to share common setup or constraints between actions.
      def set_customer
        @customer = Customer.find(params[:id])
      end

      def get_customer
        if session[:customer_id].nil?
          @customer = Customer.create
          session[:customer_id] = @customer.id
          @customer
        else
          @customer = Customer.find(session[:customer_id])
        end
      end

      # Only allow a trusted parameter "white list" through.
      def customer_params
        params.require(:customer).permit(:title, :first_name, :last_name, :email, :phone, :address, :city, :state, :zip, :country, :reservation_ids => [])
      end
  end
end

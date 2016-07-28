require_dependency "booking/application_controller"

module Booking
  class ServiceTypesController < ApplicationController
    before_action :set_service_type, only: [:show, :edit, :update, :destroy]

    # GET /service_types
    def index
      @service_types = ServiceType.all
    end

    # GET /service_types/1
    def show
      @service_type = ServiceType.find(params[:id])
    end

    # GET /service_types/new
    def new
      @service_type = ServiceType.new
    end

    # GET /service_types/1/edit
    def edit
  
    end

    # POST /service_types
    def create
      @service_type = ServiceType.new(service_type_params)

      if !@service_type.price
        @service_type.price = @service_type.default_price
      end

      if @service_type.save
        redirect_to @service_type, notice: 'Service type was successfully created.'
      else
        render :new
      end
    end

    # PATCH/PUT /service_types/1
    def update
      if @service_type.update(service_type_params)
        redirect_to @service_type, notice: 'Service type was successfully updated.'
      else
        render :edit
      end
    end

    # DELETE /service_types/1
    def destroy
      @service_type.destroy
      redirect_to service_types_url, notice: 'Service type was successfully destroyed.'
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_service_type
        @service_type = ServiceType.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def service_type_params
        params.require(:service_type).permit(:name, :max_occupancy, :price, :availability, :service_description, :default_price, :available_from, :available_to)
      end
  end
end

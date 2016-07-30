require_dependency "booking/application_controller"

module Booking
  class ServiceTypesController < ApplicationController
    before_action :set_service_type, only: [:show, :edit, :update, :destroy]

    # GET /service_types
    def index
      #Check for date valid services
      @service_types = []
      all_service_types = ServiceType.all  
      all_service_types.each do |service_type|
        #if there is a start date
        if(service_type.available_from)
          if (service_type.available_from < Date.today)
            from_valid = true
          else
            to_valid = false
          end
        else
          from_valid = true
        end
        # if there is an end date
        if(service_type.available_to)
          if(service_type.available_to > Date.today)
            to_valid = true
          else
            to_valid = false
          end
        else
          to_valid = true
        end

        #if valid or default price (non special price)
        if (from_valid && to_valid)
          @service_types << service_type   
        elsif service_type.default_price
          service_type.price = service_type.default_price
          @service_types << service_type
        end
      end
    end

    # GET /service_types/1
    def show
      @service_type = ServiceType.find(params[:id])
              #if there is a start date
        if(@service_type.available_from)
          if (@service_type.available_from < Date.today)
            from_valid = true
          else
            to_valid = false
          end
        else
          from_valid = true
        end
        # if there is an end date
        if(@service_type.available_to)
          if(@service_type.available_to > Date.today)
            to_valid = true
          else
            to_valid = false
          end
        else
          to_valid = true
        end

        #if not valid and there's a default price
        if (!from_valid || !to_valid) && @service_type.default_price
          @service_type.price = @service_type.default_price
        end
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

      # If there is no special, use default
      if @service_type.price == nil
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

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
        showPrice(service_type)
      end
    end

    # GET /service_types/1
    def show
      @service_type = ServiceType.find(params[:id])
      setPrice(@service_type)
    end

    # GET /service_types/new
    def new
      @service_type = ServiceType.new
      @service_type.service_type_reservations.build(service_type_id: @service_type.id)
    end

    # GET /service_types/1/edit
    def edit
      setDuration(@service_type)
    end

    # POST /service_types
    def create
      @service_type = ServiceType.new(service_type_params)
      setPrice(@service_type)
      setDuration(@service_type)
      if @service_type.save
        redirect_to @service_type, notice: 'Service type was successfully created.'
      else
        render :new
      end
    end

    # PATCH/PUT /service_types/1
    def update
      setPrice(@service_type)
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
        params.require(:service_type).permit(:name, :max_occupancy, :special_price, :price, :availability, :description, :default_price, :available_from, :available_to, :duration, :multiple_day)
      end

      #Set prices of all types based on dates
      def showPrice(type)
      #if there is a start date
        if(type.available_from)
          if (type.available_from <= Date.today)
            from_valid = true
          else
            to_valid = false
          end
        else
          from_valid = true
        end

        # if there is an end date
        if(type.available_to)
          if(type.available_to >= Date.today)
            to_valid = true
          else
            to_valid = false
          end
        else
          to_valid = true
        end

        #if valid and there's a special price
        if (from_valid && to_valid && type.special_price) 
          type.price = type.special_price
          @service_types << type 
          #if there's no special  
        elsif type.default_price
          type.price = type.default_price
          @service_types << type
        end
      end

      def setPrice(service)
        #set special to not valid
        from_valid = false
        to_valid = false

        #if there is a valid start date
        if(service.available_from)
          if (service.available_from <= Date.today)
            from_valid = true
          end
        end

        # if there is a valid end date
        if(service.available_to)
          if(service.available_to >= Date.today)
            to_valid = true
          end
        end

        #if not valid and there's a default price
        if (( !from_valid || !to_valid ) && service.default_price) || !service.special_price
          service.price = service.default_price
        elsif (from_valid || to_valid) && service.special_price
            service.price = service.special_price
        end
      end

      def setDuration(service)
        if (!service.multiple_day)
          if params[:duration] == nil
            service.duration = 1
          end
        else
          service.duration = nil
        end
      end
  end
end

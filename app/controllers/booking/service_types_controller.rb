require_dependency "booking/application_controller"

module Booking
  class ServiceTypesController < ApplicationController
    before_action :set_service_type, only: [:show, :edit, :update, :destroy]

    # GET /service_types
    def index
      #Check for date valid services
      @service_types = []
      @service_types = ServiceType.all
    end

    # GET /service_types/1
    def show
      @service_type = ServiceType.find(params[:id])
      @currentPrice = setPrice(@service_type)
    end

    # GET /service_types/new
    def new
      @category = Category.find(params[:category_id])
      @service_type = @category.service_types.build
      @service_type.service_type_reservations.build(service_type_id: @service_type.id)
      @service_calendar = @service_type.service_calendars.build(service_type_id: @service_type.id)
      @service_type.timeslots.build
      @service_type.build_blocked_day
    end

    # GET /service_types/1/edit
    def edit

    end

    # POST /service_types
    def create
      @category = Category.find(params[:category_id])
      @service_type = @category.service_types.create!(service_type_params)
      setDuration(@category, @service_type)
      setCalendarDaySpecialAvailability(@service_type.id)
      if @service_type.save
        redirect_to [@category, @service_type], notice: 'Service type was successfully created.'
      else
        render :new
      end
    end

    # PATCH/PUT /service_types/1
    def update
      setDuration(@category, @service_type)
      setCalendarDaySpecialAvailability(@service_type.id)
      if @service_type.update(service_type_params)
        redirect_to [@category, @service_type], notice: 'Service type was successfully updated.'
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
        @category = Category.find(params[:category_id])
        @service_type = ServiceType.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def service_type_params
        params.require(:service_type).permit(:special_availability, :adult_child_field, :max_adult_occupancy, :max_child_occupancy, :adult_compulsory, :category_id, :name, :max_occupancy, :price, :availability, :description, :default_price, :booking_limit, :booking_limit_bool, :special_price, :available_from, :available_to, :special_mondays, :special_tuesdays, :special_wednesdays, :special_thursdays, :special_fridays, :special_saturdays, :special_sundays, :special_monday_price, :special_tuesday_price, :special_wednesday_price, :special_thursday_price, :special_friday_price, :special_saturday_price, :special_sunday_price, :duration, :multiple_day, service_calendar_attributes: [:special_availability, :normal_availability, :day_availability, :day_rate, :date], timeslots_attributes: [:id, :time, :availability, :timeslot_cost, :_destroy], blocked_day_attributes: [:id, :blocked_from_date, :blocked_to_date, :monday, :tuesday, :wednesday, :thursday, :friday, :saturday, :sunday])
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
          return service.default_price
        elsif (from_valid || to_valid) && service.special_price
            return service.special_price
        end
      end

      def setDuration(category, service)
        if (!category.multiple_day)
          if params[:duration] == nil
            service.duration = 1
          end
        else
          service.duration = nil
        end
      end

      #Set availabilities for specials
      # 0 availability = fully booked. Nil means not set (no availability limit)
      def setCalendarDaySpecialAvailability(service_id)
        @service = ServiceType.find(service_id)
        #Delete previous calendar specials
        ServiceCalendar.where(service_type_id: service_id).delete_all

        #IF there's a special event
        if (@service.available_from && @service.available_to)
          #If the special hasn't passed (skip the loop)
          if(@service.available_to > Date.today)
            #Set the date for the service calendar
            (@service.available_from..@service.available_to).each do |special_day|
              normal_availability = @service.availability
              day_availability = (normal_availability || 0) + (@service.special_availability || 0)
              #Create new service calendar associations
              @service.service_calendars.create!(service_type_id: service_id, date: special_day, special_availability: @service.special_availability, normal_availability: normal_availability, day_availability: day_availability)
            end
          end
        end
      end
  end
end

require_dependency "booking/application_controller"

module Booking
  class ReservationsController < ApplicationController
    before_action :set_reservation, only: [:show, :edit, :update, :destroy]
    respond_to :html, :json

    # GET /reservations
    def index
      @reservations = Reservation.all
      @reservations.each do |reservation|
        #setReservationPrice(reservation)
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
      @unavailable_dates = []
      @unavailable_days = []
      @todays_services = []

      if params[:customer_id]
        @cust_id = params[:customer_id]
      end

      #If a service is chosen first
      if params[:service_type_id]
        @selected_service = ServiceType.find(params[:service_type_id])
        @selected_service_category = Category.find(@selected_service.category_id)
        @multiple_day = @selected_service_category.multiple_day
        getBlockedDates(@selected_service, @unavailable_dates)
        getBlockedDays(@selected_service, @unavailable_days)
        getFullyBookedDates(@selected_service, @unavailable_dates)
      end

      #If a category is chosen first
      if params[:category_id]
        @category = Category.find(params[:category_id])
        @multiple_day = @category.multiple_day
        @category_services = ServiceType.where(category_id: params[:category_id])
        #Check if each service is available today/not
        @category_services.each do |service|
          #if it's not a blocked day
          if (service.blocked_day.blocked_from_date && service.blocked_day.blocked_to_date)
            if !((service.blocked_day.blocked_from_date <= Date.today) &&
                (Date.today <= service.blocked_day.blocked_to_date))
              @todays_services << service
            end
          elsif (Date.today.monday? && !service.blocked_day.monday) ||
              (Date.today.tuesday? && !service.blocked_day.tuesday) ||
              (Date.today.wednesday? && !service.blocked_day.wednesday) ||
              (Date.today.thursday? && !service.blocked_day.thursday) ||
              (Date.today.friday? && !service.blocked_day.friday) ||
              (Date.today.saturday? && !service.blocked_day.saturday) ||
              (Date.today.sunday? && !service.blocked_day.sunday)
            @todays_services << service
          end
        end
      end
    end

    #Gets blocked dates for checkin. Service type must be chosen.
    def getBlockedDates(service, unavailable_dates)
      #If there is a blocked period
      if (service.blocked_day.blocked_from_date)
        (service.blocked_day.blocked_from_date.to_date..service.blocked_day.blocked_to_date.to_date).each do |bd|
          unavailable_dates << bd.strftime('%d-%m-%Y')
        end
      end
    end

    #Gets blocked days for datepickers
    def getBlockedDays(service, unavailable_days)
      #Check if day is blocked
      if(service.blocked_day.monday == true)
        #Add to array
        unavailable_days << 1
      end
      if(service.blocked_day.tuesday == true)
        unavailable_days << 2
      end
      if(service.blocked_day.wednesday == true)
        unavailable_days << 3
      end
      if(service.blocked_day.thursday == true)
        unavailable_days << 4
      end
      if(service.blocked_day.friday == true)
        unavailable_days << 5
      end
      if(service.blocked_day.saturday == true)
        unavailable_days << 6
      end
      if(service.blocked_day.sunday == true)
        unavailable_days << 0
      end
    end

    def getFullyBookedDates(service, unavailable_dates)
      #Get dates that have run out of availability
      unavailable_dates << ServiceCalendar.where(service_type_id: service.id, day_availability: 0)
    end

    #Returns dates unavailable for checkout or checkout end date if applicable
    #Checkout date must have format .strftime('%Y-%m-%d') for it to be recognised by bootstrap datepicker
    def get_checkout_dates
      @next_day = (params[:next_day]).to_date
      @end_date
      @limit_date
      @service = ServiceType.find(params[:service_type_id])
      #If next day (checkin day + 1) is a blocked day
      if ((@service.blocked_day.monday == true) && (params[:next_day]).to_date.monday?) || ((@service.blocked_day.tuesday == true) && (params[:next_day]).to_date.tuesday?) || ((@service.blocked_day.wednesday == true) && (params[:next_day]).to_date.wednesday?) || ((@service.blocked_day.thursday == true) && (params[:next_day]).to_date.thursday?) || ((@service.blocked_day.friday == true) && (params[:next_day]).to_date.friday?) || ((@service.blocked_day.saturday == true) && (params[:next_day]).to_date.saturday?) || ((@service.blocked_day.sunday == true) && (params[:next_day]).to_date.sunday?)
        #Set calendar end date to be next day
        @end_date = @next_day
      end

      #If the day after checkin isn't a blocked day
      if (!@end_date)
        #Check if there's a booking limit
        @limit = @service.booking_limit
        if @limit
          @limit_date = (@next_day + (@limit.days - 1))
        end

        #Set as 7 days later, need to find closer date if applicable
        @days_till_blocked = 7
        #Find the closest blocked day if applicable
        if (@service.blocked_day.monday == true)
          #Count how many days till blocked
          (@next_day..(@next_day + 6)).each_with_index do |day, index|
            if (day.monday? == true)
              if(index < @days_till_blocked)
                @days_till_blocked = index
              end
              break
            end
          end
        end
        if (@service.blocked_day.tuesday == true)
          #Count how many days till blocked
          (@next_day..(@next_day + 6)).each_with_index do |day, index|
            if (day.tuesday? == true)
              if(index < @days_till_blocked)
                @days_till_blocked = index
              end
              break
            end
          end
        end
        if (@service.blocked_day.wednesday == true)
          #Count how many days till blocked
          (@next_day..(@next_day + 6)).each_with_index do |day, index|
            if (day.wednesday? == true)
              if(index < @days_till_blocked)
                @days_till_blocked = index
              end
              break
            end
          end
        end
        if (@service.blocked_day.thursday == true)
          #Count how many days till blocked
          (@next_day..(@next_day + 6)).each_with_index do |day, index|
            if (day.thursday? == true)
              if(index < @days_till_blocked)
                @days_till_blocked = index
              end
              break
            end
          end
        end
        if (@service.blocked_day.friday == true)
          #Count how many days till blocked
          (@next_day..(@next_day + 6)).each_with_index do |day, index|
            if (day.friday? == true)
              if(index < @days_till_blocked)
                @days_till_blocked = index
              end
              break
            end
          end
        end
        if (@service.blocked_day.saturday == true)
          #Count how many days till blocked
          (@next_day..(@next_day + 6)).each_with_index do |day, index|
            if (day.saturday? == true)
              if(index < @days_till_blocked)
                @days_till_blocked = index
              end
              break
            end
          end
        end
        if (@service.blocked_day.sunday == true)
          #Count how many days till blocked
          (@next_day..(@next_day + 6)).each_with_index do |day, index|
            if (day.sunday? == true)
              if(index < @days_till_blocked)
                @days_till_blocked = index
              end
              break
            end
          end
        end

        #If there's a blocked day
        if(@days_till_blocked < 7)
          #Get the next blocked date
          @next_blocked_day_date = @next_day + @days_till_blocked
        end

        #Loop blocked dates to find closest blocked date
        @found_end = false
        if (@service.blocked_day.blocked_from_date && @service.blocked_day.blocked_to_date)
          (@service.blocked_day.blocked_from_date.to_date..@service.blocked_day.blocked_to_date.to_date).each do |bd|
            if (@found_end == false)
              #If the blocked date is after the checkin date
              if (bd >= @next_day)
                #Compare the next blocked day and the booking limit
                if (@limit_date && (@limit_date < bd))
                  @end_date = @limit_date
                else
                  #Set the calendar end date to the first blocked day
                  @end_date = bd
                end
                @found_end = true
              end
            end
          end
        end

        #If there's an end day and a valid block day
        if (@next_blocked_day_date)
          #If there's an end date AND blocked day date is closer or if there isn't and end date
          if ((@end_date && (@next_blocked_day_date < @end_date.to_date)) || (!@end_date))
            #Set end date
            @end_date = @next_blocked_day_date
          end
        end
        #If there's no end date, and there is a limit date
        if(!@end_date && @limit_date)
            @end_date = @limit_date
        end
      end
      if(@end_date)
        @end_date = @end_date.strftime('%Y-%m-%d')
      end
    end


    #Displays prices for available services
    def display_prices
      @service_type = ServiceType.find(params[:service_type_id])
      @default_price = @service_type.default_price
      #Get special dates and prices
      @special_start = @service_type.available_from
      @special_end = @service_type.available_to
      @special_price = @service_type.special_price

      if(@service_type.special_mondays == true)
        @special_monday_price = @service_type.special_monday_price
      end
      if(@service_type.special_tuesdays == true)
        @special_tuesday_price = @service_type.special_tuesday_price
      end
      if(@service_type.special_wednesdays == true)
        @special_wednesday_price = @service_type.special_wednesday_price
      end
      if(@service_type.special_thursdays == true)
        @special_thursday_price = @service_type.special_thursday_price
      end
      if(@service_type.special_fridays == true)
        @special_friday_price = @service_type.special_friday_price
      end
      if(@service_type.special_saturdays == true)
        @special_saturday_price = @service_type.special_saturday_price
      end
      if(@service_type.special_sundays == true)
        @special_sunday_price = @service_type.special_sunday_price
      end
    end

    # Service selection for multiple day category
    def display_multiple_day_services
      @check_in = Date.parse(params[:check_in])
      @check_out = Date.parse(params[:check_out])

      #Find available services
      @services = []
      @available_services = []
      #Get all services in the category given
      @services = ServiceType.where(category_id: params[:category_id])

      #Filter blocked services out
      @services.each do |s|
        @blocked = false
        #If there are blocked dates
        if (s.blocked_day.blocked_from_date && s.blocked_day.blocked_to_date)
          #If blocked
          if !((s.blocked_day.blocked_to_date < @check_in) || (s.blocked_day.blocked_from_date > @check_out))
            @blocked = true
          end
        end
        #Check block days
        (@check_in..@check_out).each do |d|
          if (d.monday? && s.blocked_day.monday)
            @blocked = true
          elsif (d.tuesday? && s.blocked_day.tuesday)
            @blocked = true
          elsif (d.wednesday? && s.blocked_day.wednesday)
            @blocked = true
          elsif (d.thursday? && s.blocked_day.thursday)
            @blocked = true
          elsif (d.friday? && s.blocked_day.friday)
            @blocked = true
          elsif (d.saturday? && s.blocked_day.saturday)
            @blocked = true
          elsif (d.sunday? && s.blocked_day.sunday)
            @blocked = true
          end
        end

        #If service isn't blocked, add to available_services
        if(@blocked == false)
          @available_services << s
        end
      end
    end

    # Service selection for single day category
    def display_single_day_services
      @check_in = Date.parse(params[:check_in])
      #Find available services
      @services = []
      @available_services = []
      #Get all services in the category given
      @services = ServiceType.where(category_id: params[:category_id])

      #Filter blocked services out
      @services.each do |s|
        @blocked = false
        #If there are blocked dates
        if (s.blocked_day.blocked_from_date && s.blocked_day.blocked_to_date)
          #If blocked
          if !((s.blocked_day.blocked_to_date < @check_in) || (s.blocked_day.blocked_from_date > @check_in))
            @blocked = true
          end
        end
        #Check block days

        case(@check_in.wday)
        when 0
          if (s.blocked_day.sunday)
            @blocked = true
          end
        when 1
          if (s.blocked_day.monday)
            @blocked = true
          end
        when 2
          if (s.blocked_day.tuesday)
            @blocked = true
          end
        when 3
          if (s.blocked_day.wednesday)
            @blocked = true
          end
        when 4
          if (s.blocked_day.thursday)
            @blocked = true
          end
        when 5
          if (s.blocked_day.friday)
            @blocked = true
          end
        when 6
          if (s.blocked_day.saturday)
            @blocked = true
          end
        end

        #If there are timeslots
        if (s.timeslots.length > 0)
          @no_slots = true
          #Check if there are available timeslots
          s.timeslots.each do |tslot|
            #If a valid timeslot hasn't been found
            if (@no_slots == true)
              #Check if valid timeslot
              if(tslot.availability && tslot.availability > 0)
                #There's a valid timeslot
                @no_slots = false
              end
            end
          end
        else
          @no_slots = false
        end

        #If service isn't blocked & there is a valid timeslot, add to available_services
        if((@blocked == false) && (@no_slots == false))
          @available_services << s
        end
      end
    end

    def display_timeslots
      @service_calendar = ServiceCalendar.where(service_type_id: params[:service_type_id], date: params[:query_date])
      @timeslots = @service_calendar.timeslots
      if (@timeslots.length > 0)
        @has_slots = true
      else
        @has_slots = false
      end
    end

    def display_occupancy
      @service = ServiceType.find(params[:service_type_id])
      @adult_child_required = @service.adult_child_field
      @max_occupancy = @service.max_occupancy
      if (@adult_child_required == true)
        @adult_compulsory = @service.adult_compulsory
        @max_adult_occupancy = @service.max_adult_occupancy
        @max_child_occupancy = @service.max_child_occupancy
      end
    end

    def display_child_occupancy
      @service = ServiceType.find(params[:service_type_id])
      @max_child_occupancy = @service.max_child_occupancy
      @max_occupancy = @service.max_occupancy
      @adult_occupancy = (params[:adult_occupancy]).to_i

      #Calculate new max child occupancy
      if((@max_occupancy - @adult_occupancy) < @max_child_occupancy)
        @max_child_occupancy = (@max_occupancy - @adult_occupancy)
      end
    end

    # GET /reservations/1/edit
    def edit
      @single_reservation = @reservation.service_type_reservations.find(params[:single_service_reservation_id])
      @selected_service = ServiceType.find(@single_reservation.service_type_id)
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
          format.html { params.require(:reservation).permit(:updated_at, :created_at, :total_price, customer_reservation_attributes: [:customer_id], service_type_reservations_attributes: [:id, :occupancy, :check_in, :check_out, :date, :time, :adult, :child, :service_type_id, :_destroy])}
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
          my_category = Category.find(my_service.category_id)
          if (!my_category.multiple_day)
            service_res.check_in = service_res.date
            service_res.check_out = service_res.date + my_service.duration.hours
          end
        end
      end
  end
end

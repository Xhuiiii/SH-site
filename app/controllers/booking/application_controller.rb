#Provides any common functionality for the controllers of the engine
#Where other controllers for the booking engine will go
# Add 'require_dependency "booking/application_controller"' to other controllers to ensure they are inheriting
# from this controller and not the main application's controller

module Booking
  class ApplicationController < ActionController::Base
    #Takes a service type, date, and optional time.
    #Returns price for that day/timeslot
    def getPrice(service_type_id, date, time)
      service_type = ServiceType.find(service_type_id)
      #If there's a time
      if(time)
        timeslot = service_type.timeslots.find(time)
        if (timeslot.timeslot_cost)
          return timeslot.timeslot_cost
        else
          return service_type.default_price
        end
      #Using date
      else
        d = date.to_date
        #If there's a special price
        if service_type.special_price
          #Check if date falls between special
          if (d >= service_type.available_from.to_date && d <= service_type.available_from.to_date)
            return service_type.special_price
          end
        elsif d.monday? && service_type.special_monday_price
          return service_type.special_monday_price
        elsif d.tuesday? && service_type.special_tuesday_price
          return service_type.special_tuesday_price
        elsif d.wednesday? && service_type.special_wednesday_price
          return service_type.special_wednesday_price
        elsif d.thursday? && service_type.special_thursday_price
          return service_type.special_thursday_price
        elsif d.friday? && service_type.special_friday_price
          return service_type.special_friday_price
        elsif d.saturday? && service_type.special_saturday_price
          return service_type.special_saturday_price
        elsif d.sunday? && service_type.special_sunday_price
          return service_type.special_sunday_price
        else
          return service_type.default_price
        end
      end
    end
  end
end

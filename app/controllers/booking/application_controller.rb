#Provides any common functionality for the controllers of the engine
#Where other controllers for the booking engine will go
# Add 'require_dependency "booking/application_controller"' to other controllers to ensure they are inheriting
# from this controller and not the main application's controller

module Booking
  class ApplicationController < ActionController::Base
    def after_sign_in_path_for(resource)
      (booking||self).reservations_path
    end

    def after_sign_out_path_for(resource)
      (booking||self).categories_path
    end
    #Takes a service type, date, and optional time.
    #Returns price for that day/timeslot
    def getPrice(service_type_id, date, time_id)
      service_type = ServiceType.find(service_type_id)
      price = nil

      #If there's a time
      if(time_id && time_id.present?)
        timeslot = service_type.timeslots.find(time_id)
        if (timeslot.timeslot_cost)
          price = timeslot.timeslot_cost
        else
          price = service_type.default_price
        end
      #Using date
      else
        d = date.to_date
        d.change(hour: 0)
        #If there's a special price
        if service_type.special_price
          #Check if date falls between special
          special_start = service_type.available_from.to_date.change(hour: 0)
          special_end = service_type.available_to.to_date.change(hour: 0)
          if (d >= special_start && d <= special_end)
            price = service_type.special_price
          end
        end
        if price == nil
          if (d.monday? && service_type.special_monday_price)
            price = service_type.special_monday_price
          elsif d.tuesday? && service_type.special_tuesday_price
            price = service_type.special_tuesday_price
          elsif d.wednesday? && service_type.special_wednesday_price
            price = service_type.special_wednesday_price
          elsif d.thursday? && service_type.special_thursday_price
            price = service_type.special_thursday_price
          elsif d.friday? && service_type.special_friday_price
            price = service_type.special_friday_price
          elsif d.saturday? && service_type.special_saturday_price
            price = service_type.special_saturday_price
          elsif d.sunday? && service_type.special_sunday_price
            price = service_type.special_sunday_price
          else
            price = service_type.default_price
          end
        end
      end
      return price
    end
  end
end

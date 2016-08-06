module Booking
  class ServiceTypeReservation < ActiveRecord::Base
  	belongs_to :service_type
  	belongs_to :reservation
  	belongs_to :service_calendar
  end
end

module Booking
  class ServiceCalendar < ActiveRecord::Base
  	has_many :service_types
  	has_many :customers
  	has_many :reservations
  end
end

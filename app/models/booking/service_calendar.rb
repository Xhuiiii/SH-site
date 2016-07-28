module Booking
  class ServiceCalendar < ActiveRecord::Base
  	has_many :service_types
  end
end

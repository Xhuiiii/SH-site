module Booking
  class ServiceCalendar < ActiveRecord::Base
  	has_many :service_type_reservations, dependent: :destroy
  end
end

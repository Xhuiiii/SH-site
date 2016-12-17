module Booking
  class ServiceCalendar < ActiveRecord::Base
    belongs_to :service_type
  	has_many :service_type_reservations, dependent: :destroy
  end
end

module Booking
  class ServiceTypeReservation < ActiveRecord::Base
  	belongs_to :service_type
  	belongs_to :reservation
  	belongs_to :service_calendar

  	validates :service_type, presence: true
  end
end

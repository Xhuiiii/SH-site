module Booking
  class ServiceCalendar < ActiveRecord::Base
    belongs_to :service_type
  	has_many :service_type_reservations, dependent: :destroy
    has_many :reservations, through: :service_types, dependent: :destroy
    has_many :calendar_day_timeslots, dependent: :destroy
    accepts_nested_attributes_for :calendar_day_timeslots, allow_destroy: true
  end
end

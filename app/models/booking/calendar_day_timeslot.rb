module Booking
  class CalendarDayTimeslot < ActiveRecord::Base
    belongs_to :service_calendar
  end
end

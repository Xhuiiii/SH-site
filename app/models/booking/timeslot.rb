module Booking
  class Timeslot < ActiveRecord::Base
  	belongs_to :service_type
  end
end

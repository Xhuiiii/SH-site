module Booking
  class Reservation < ActiveRecord::Base
  	has_and_belongs_to_many :service_types
  	has_and_belongs_to_many :customers
  end
end

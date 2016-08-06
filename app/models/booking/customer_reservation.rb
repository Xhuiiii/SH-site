module Booking
  class CustomerReservation < ActiveRecord::Base
  	belongs_to :customer
  	belongs_to :reservation
  end
end

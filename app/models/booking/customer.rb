module Booking
  class Customer < ActiveRecord::Base
  	has_one :reservation, dependent: :destroy
  end
end

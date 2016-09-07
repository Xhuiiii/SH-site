module Booking
  class BlockedDay < ActiveRecord::Base
  	belongs_to :service_type
  end
end
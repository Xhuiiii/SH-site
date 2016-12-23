module Booking
  class UserReservation < ActiveRecord::Base
    belongs_to :user
    belongs_to :reservation
  end
end

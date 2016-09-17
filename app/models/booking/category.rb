module Booking
  class Category < ActiveRecord::Base
  	has_many :service_types, dependent: :destroy
  end
end
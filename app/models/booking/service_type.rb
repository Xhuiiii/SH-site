module Booking
  class ServiceType < ActiveRecord::Base
    belongs_to :category
  	has_many :service_type_reservations, dependent: :destroy
  	has_many :reservations, through: :service_type_reservations, dependent: :destroy
  	has_one :blocked_day, dependent: :destroy
  	accepts_nested_attributes_for :blocked_day, allow_destroy: true
  	has_many :timeslots, dependent: :destroy
  	accepts_nested_attributes_for :timeslots, allow_destroy: true

  	validates :name, :length => {:minimum => 1}
  	validates_presence_of :default_price
  end
end

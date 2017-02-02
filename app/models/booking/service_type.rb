module Booking
  class ServiceType < ActiveRecord::Base
    belongs_to :category
  	has_many :service_type_reservations, dependent: :destroy
  	has_many :reservations, through: :service_type_reservations, dependent: :destroy
  	has_one :blocked_day, dependent: :destroy
  	accepts_nested_attributes_for :blocked_day, allow_destroy: true
    has_many :service_calendars, dependent: :destroy
    accepts_nested_attributes_for :service_calendars, allow_destroy: true
    has_many :timeslots, dependent: :destroy
    accepts_nested_attributes_for :timeslots, allow_destroy: true, reject_if: :time_nil

  	validates :name, :length => {:minimum => 1}
  	validates_presence_of :default_price
    validates :max_occupancy, allow_blank: true, :numericality => {:greater_than_or_equal_to => 1}

    private

    def time_nil(attributes)
      attributes['time'].nil? || attributes['time'].blank? || attributes['availability'].nil?
    end
  end
end

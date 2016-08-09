class AddMultipleDayToBookingServiceTypes < ActiveRecord::Migration
  def change
  	add_column :booking_service_types, :multiple_day, :boolean
  end
end

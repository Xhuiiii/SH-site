class AddDurationToBookingServiceTypes < ActiveRecord::Migration
  def change
  	add_column :booking_service_types, :duration, :integer
  end
end

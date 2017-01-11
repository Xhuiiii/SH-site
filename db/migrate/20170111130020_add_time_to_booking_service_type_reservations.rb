class AddTimeToBookingServiceTypeReservations < ActiveRecord::Migration
  def change
  	add_column :booking_service_type_reservations, :time, :time
  end
end

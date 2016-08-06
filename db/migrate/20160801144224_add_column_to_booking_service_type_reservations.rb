class AddColumnToBookingServiceTypeReservations < ActiveRecord::Migration
  def change
  	add_column :booking_service_type_reservations, :service_type_id, :integer
  	add_column :booking_service_type_reservations, :reservation_id, :integer
  end
end

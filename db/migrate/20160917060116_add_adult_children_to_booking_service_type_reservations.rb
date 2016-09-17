class AddAdultChildrenToBookingServiceTypeReservations < ActiveRecord::Migration
  def change
  	add_column :booking_service_type_reservations, :adult, 'integer unsigned'
  	add_column :booking_service_type_reservations, :child, 'integer unsigned'
  end
end

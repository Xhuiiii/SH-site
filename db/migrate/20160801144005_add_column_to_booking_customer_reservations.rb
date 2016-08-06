class AddColumnToBookingCustomerReservations < ActiveRecord::Migration
  def change
  	add_column :booking_customer_reservations, :customer_id, :integer
  	add_column :booking_customer_reservations, :reservation_id, :integer
  end
end

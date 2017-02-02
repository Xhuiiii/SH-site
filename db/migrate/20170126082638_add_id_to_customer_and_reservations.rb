class AddIdToCustomerAndReservations < ActiveRecord::Migration
  def change
    add_column :booking_customers, :reservation_id, :integer
    add_column :booking_reservations, :customer_id, :integer
  end
end

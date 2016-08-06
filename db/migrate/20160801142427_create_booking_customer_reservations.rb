class CreateBookingCustomerReservations < ActiveRecord::Migration
  def change
    create_table :booking_customer_reservations do |t|

      t.timestamps null: false
    end
  end
end

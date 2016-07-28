class CreateBookingReservations < ActiveRecord::Migration
  def change
    create_table :booking_reservations do |t|
      t.integer :reservation_ID
      t.float :total_price
      t.integer :occupancy
      t.date :check_in
      t.date :check_out
      t.date :date
      t.integer :customer_ID
      t.integer :service_ID

      t.timestamps null: false
    end
  end
end

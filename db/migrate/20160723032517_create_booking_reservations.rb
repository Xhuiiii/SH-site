class CreateBookingReservations < ActiveRecord::Migration
  def change
    create_table :booking_reservations do |t|
      t.float :total_price
      t.integer :occupancy
      t.date :check_in
      t.date :check_out
      t.date :date
      t.time :time

      t.timestamps null: false
    end
  end
end

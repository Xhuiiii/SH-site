class CreateBookingReservations < ActiveRecord::Migration
  def change
    create_table :booking_reservations do |t|
      t.float :total_price
      t.datetime :check_in
      t.datetime :check_out
      t.datetime :date
      t.float :single_res_price
      t.integer :occupancy
      t.timestamps null: false
    end
  end
end

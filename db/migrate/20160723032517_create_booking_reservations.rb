class CreateBookingReservations < ActiveRecord::Migration
  def change
    create_table :booking_reservations do |t|
      t.float :total_price
      t.integer :single_service_reservation_id
      t.timestamps null: false
    end
  end
end

class CreateBookingServiceTypeReservations < ActiveRecord::Migration
  def change
    create_table :booking_service_type_reservations do |t|
      t.datetime :check_in
      t.datetime :check_out
      t.datetime :date
      t.integer :occupancy
      t.timestamps null: false
    end
  end
end

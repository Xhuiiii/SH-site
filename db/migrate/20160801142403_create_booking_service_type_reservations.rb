class CreateBookingServiceTypeReservations < ActiveRecord::Migration
  def change
    create_table :booking_service_type_reservations do |t|

      t.timestamps null: false
    end
  end
end

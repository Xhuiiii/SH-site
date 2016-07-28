class CreateBookingTodaysBookings < ActiveRecord::Migration
  def change
    create_table :booking_todays_bookings do |t|
      t.date :date
      t.integer :service_type_ID
      t.integer :reservation_ID
      t.integer :customer_ID
      t.float :rate

      t.timestamps null: false
    end
  end
end

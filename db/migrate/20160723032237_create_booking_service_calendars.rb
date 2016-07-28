class CreateBookingServiceCalendars < ActiveRecord::Migration
  def change
    create_table :booking_service_calendars do |t|
      t.integer :service_type_ID
      t.integer :availability
      t.integer :reservation
      t.float :rate
      t.date :date

      t.timestamps null: false
    end
  end
end

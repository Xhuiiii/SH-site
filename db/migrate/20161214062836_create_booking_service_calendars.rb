class CreateBookingServiceCalendars < ActiveRecord::Migration
  def change
    create_table :booking_service_calendars do |t|
      t.integer :day_availability
      t.float :day_rate
      t.date :date
      t.integer :service_type_id

      t.timestamps null: false
    end
  end
end

class CreateBookingCalendarDayTimeslots < ActiveRecord::Migration
  def change
    create_table :booking_calendar_day_timeslots do |t|
      t.time :time
    	t.integer :availability
      t.float :timeslot_cost
    	t.integer :service_calendar_id
      t.timestamps null: false
    end
  end
end

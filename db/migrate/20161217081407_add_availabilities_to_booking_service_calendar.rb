class AddAvailabilitiesToBookingServiceCalendar < ActiveRecord::Migration
  def change
    add_column :booking_service_calendars, :special_availability, 'integer unsigned'
    add_column :booking_service_calendars, :normal_availability, 'integer unsigned'
  end
end

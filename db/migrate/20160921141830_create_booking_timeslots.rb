class CreateBookingTimeslots < ActiveRecord::Migration
  def change
    create_table :booking_timeslots do |t|
    	t.time :time
    	t.integer :availability
      t.float :timeslot_cost
    	t.integer :service_type_id
    end
  end
end

class CreateBookingBlockedDays < ActiveRecord::Migration
  def change
    create_table :booking_blocked_days do |t|
    	t.date :blocked_from_date
    	t.date :blocked_to_date
    	#Permanent off days
    	t.boolean :monday
    	t.boolean :tuesday
    	t.boolean :wednesday
    	t.boolean :thursday
    	t.boolean :friday 
    	t.boolean :saturday 
    	t.boolean :sunday
    	t.integer :service_type_id
    end
  end
end

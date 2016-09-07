class CreateBookingBlockedDays < ActiveRecord::Migration
  def change
    create_table :booking_blocked_days do |t|
    	t.date :blocked_from_date
    	t.date :blocked_to_date
    	t.boolean :permanent
    	t.integer :occurance
    end
  end
end

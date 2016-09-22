class AddExtraCostToBookingTimeslots < ActiveRecord::Migration
  def change
  	add_column :booking_timeslots, :extra_cost, 'integer unsigned'
  end
end

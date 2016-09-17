class AddAdultChildrenOrPersonsToBookingServiceTypes < ActiveRecord::Migration
  def change
  	add_column :booking_service_types, :adult_child_field, :boolean
  end
end

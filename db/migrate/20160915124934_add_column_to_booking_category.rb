class AddColumnToBookingCategory < ActiveRecord::Migration
  def change
  	add_column :booking_categories, :multiple_day, :boolean
  	add_column :booking_categories, :name, :string
  	remove_column :booking_service_types, :multiple_day, :boolean
  end
end

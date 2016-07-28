class AddDescriptionToServiceTypes < ActiveRecord::Migration
  def change
    add_column :booking_service_types, :service_description, :text
  end
end

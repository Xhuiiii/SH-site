class AddFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :booking_users, :first_name, :string
    add_column :booking_users, :last_name, :string
    add_column :booking_users, :title, :string
    add_column :booking_users, :phone, :string
    add_column :booking_users, :address, :string
    add_column :booking_users, :city, :string
    add_column :booking_users, :state, :string
    add_column :booking_users, :zip, :string
    add_column :booking_users, :country, :string
  end
end

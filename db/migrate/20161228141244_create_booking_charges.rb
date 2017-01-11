class CreateBookingCharges < ActiveRecord::Migration
  def change
    create_table :booking_charges do |t|

      t.timestamps null: false
    end
  end
end

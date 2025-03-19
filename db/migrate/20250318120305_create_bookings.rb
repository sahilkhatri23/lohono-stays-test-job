class CreateBookings < ActiveRecord::Migration[7.2]
  def change
    create_table :bookings do |t|
      t.references :villa, null: false, foreign_key: true
      t.datetime :check_in
      t.datetime :check_out
      t.integer :price

      t.timestamps
    end
  end
end

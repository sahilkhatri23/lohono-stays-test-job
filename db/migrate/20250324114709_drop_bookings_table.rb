class DropBookingsTable < ActiveRecord::Migration[7.2]
  def up
    drop_table :bookings
  end

  def down
    create_table :bookings do |t|
      t.references :villa, null: false, foreign_key: true
      t.date :check_in
      t.date :check_out
      t.integer :price
      t.timestamps
    end
  end
end

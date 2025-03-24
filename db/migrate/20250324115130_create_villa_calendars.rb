class CreateVillaCalendars < ActiveRecord::Migration[7.2]
  def change
    create_table :villa_calendars do |t|
      t.references :villa, null: false, foreign_key: true
      t.date :date
      t.integer :price
      t.boolean :is_available, default: true

      t.timestamps
    end
  end
end

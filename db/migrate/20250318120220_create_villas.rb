class CreateVillas < ActiveRecord::Migration[7.2]
  def change
    create_table :villas do |t|
      t.string :name
      t.integer :price_per_night

      t.timestamps
    end
  end
end

class RemovePricePerNightFromVillas < ActiveRecord::Migration[7.2]
  def change
    remove_column :villas, :price_per_night, :integer
  end
end

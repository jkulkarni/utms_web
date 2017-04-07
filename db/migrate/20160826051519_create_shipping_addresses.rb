class CreateShippingAddresses < ActiveRecord::Migration[5.0]
  def change
    create_table :shipping_addresses do |t|
      t.string :name
      t.string :address_line1
      t.string :address_line2
      t.string :city
      t.string :state_province_region
      t.string :zip_or_postal_code
      t.integer :country_id, index: true, index: true
      t.string :phone
      t.integer :no_of_sets
      t.integer :transcript_application_id, index: true, index: true
      
      t.timestamps null: false
    end
  end
end

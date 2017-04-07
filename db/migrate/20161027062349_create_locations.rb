class CreateLocations < ActiveRecord::Migration[5.0]
  def change
    create_table :locations do |t|
    	t.string :name
    	t.integer :amount
    	t.integer :service_days
    	t.integer :discount

      t.timestamps
    end
  end
end

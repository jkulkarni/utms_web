class CreateStates < ActiveRecord::Migration[5.0]
  def change
    create_table :states do |t|
    	t.string :name
    	t.string :iso
    	t.integer :country_id, index: true, index: true
    	
      t.timestamps
    end
  end
end

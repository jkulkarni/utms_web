class CreateTransactions < ActiveRecord::Migration[5.0]
  def change
    create_table :transactions do |t|
	    t.string :express_token
		  t.string :express_payer_id
 	  	t.integer :order_id, index: true, index: true
    	t.string :ip_address
    	t.string :first_name
    	t.string :last_name
    	t.string :card_type
  		t.date :card_expires_on

      t.timestamps
    end
  end
end

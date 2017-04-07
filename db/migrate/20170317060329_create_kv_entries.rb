class CreateKvEntries < ActiveRecord::Migration[5.0]
  def change
    create_table :kv_entries do |t|
      t.string :key
      t.string :value
      t.references :payment_notification, foreign_key: true

      t.timestamps
    end
  end
end

class CreateUniversities < ActiveRecord::Migration[5.0]
  def change
    create_table :universities do |t|
      t.string :name
      t.string :address
      t.string :contact
      t.integer :university_code
      t.integer :transcript_application_id, index: true, index: true
      
      t.timestamps null: false
    end
  end
end

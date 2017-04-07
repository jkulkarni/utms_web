class CreateColleges < ActiveRecord::Migration[5.0]
  def change
    create_table :colleges do |t|
      t.string :name
      t.string :code
      t.string :region
      t.string :city
      t.string :address
      t.string :contact
      t.boolean :outsideCollege
      t.boolean :autonomous_college
      t.integer :university_id, index: true, index: true
      t.integer :transcript_application_id, index: true

      t.timestamps null: false
    end
  end
end

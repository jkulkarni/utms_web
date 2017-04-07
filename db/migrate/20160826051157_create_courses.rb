class CreateCourses < ActiveRecord::Migration[5.0]
  def change
    create_table :courses do |t|
      t.string :name
	  t.integer :transcript_application_id, index: true, index: true

      t.timestamps null: false
    end
  end
end

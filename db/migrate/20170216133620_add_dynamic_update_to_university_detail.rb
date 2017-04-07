class AddDynamicUpdateToUniversityDetail < ActiveRecord::Migration[5.0]
  def change
    add_column :university_details, :dynamic_update, :string
  end
end

class AddServiceChargeToUniversityDetail < ActiveRecord::Migration[5.0]
  def change
    add_column :university_details, :service_charge, :integer
  end
end

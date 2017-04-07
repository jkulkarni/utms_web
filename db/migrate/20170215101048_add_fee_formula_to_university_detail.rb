class AddFeeFormulaToUniversityDetail < ActiveRecord::Migration[5.0]
  def change
    add_column :university_details, :fee_formula, :string
  end
end

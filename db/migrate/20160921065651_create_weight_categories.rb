class CreateWeightCategories < ActiveRecord::Migration[5.0]
  def change
    create_table :weight_categories do |t|
      t.integer :weight_range_start
      t.integer :weight_range_end

      t.timestamps
    end
  end
end

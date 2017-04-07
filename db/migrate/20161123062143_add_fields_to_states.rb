class AddFieldsToStates < ActiveRecord::Migration[5.0]
  def change
    add_column :states, :state_id, :integer
  end
end

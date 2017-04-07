class AddSortnameToCountries < ActiveRecord::Migration[5.0]
  def change
    add_column :countries, :sortname, :string
    add_column :countries, :country_id, :integer
  end
end

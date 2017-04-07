class AddSubdomainToUniversity < ActiveRecord::Migration[5.0]
  def change
    add_column :universities, :subdomain, :string
  end
end

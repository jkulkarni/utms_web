class AddBannerImageToUniversity < ActiveRecord::Migration[5.0]
  def change
    add_column :universities, :banner_image, :string
  end
end

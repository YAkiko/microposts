class AddImageToMicropost < ActiveRecord::Migration
  def change
    add_column :microposts, :img, :string
    add_column :microposts, :remove_image, :boolean
  end
end

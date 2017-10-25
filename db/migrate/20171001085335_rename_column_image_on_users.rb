class RenameColumnImageOnUsers < ActiveRecord::Migration[5.0]
  def change
    rename_column :users, :image, :fb_image
  end
end

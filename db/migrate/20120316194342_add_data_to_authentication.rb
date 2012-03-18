class AddDataToAuthentication < ActiveRecord::Migration
  def up
    add_column :authentications, :data, :text
  end

  def down
    remove_column :authentications, :data
  end
end

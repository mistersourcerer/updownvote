class AddDataToAuthentication < ActiveRecord::Migration
  def up
    add_column :authentications, :data, :string
  end

  def down
    remove_column :authentications, :data
  end
end

class AddAuthenticationTable < ActiveRecord::Migration
  def up
    create_table :authentications do |t|
      t.integer :user_id
      t.string :uid
    end
  end

  def down
    drop_table :authentications
  end
end

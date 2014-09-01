class AddAppTokenToUsers < ActiveRecord::Migration
  def up
    rename_column :users, :token, :oauth_token
    add_column :users, :app_token, :string
    add_index :users, :app_token, unique: true

    User.all.each do |user|
      user.update(app_token: SecureRandom.hex(32))
    end
  end

  def down
    rename_column :users, :oauth_token, :token
    remove_column :users, :app_token
  end
end

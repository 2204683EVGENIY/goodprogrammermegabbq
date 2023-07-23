class AddOauthAvatarToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :oauth_avatar, :string
  end
end

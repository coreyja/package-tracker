class AddRefreshTokenToAuthentications < ActiveRecord::Migration[5.1]
  def change
    add_column :authentications, :refresh_token, :string, null: true
    add_column :authentications, :expires_at, :datetime, null: true
  end
end

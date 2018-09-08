class UpdateUsersForOAuth < ActiveRecord::Migration[5.0]
	def change
		change_column_null :users, :encrypted_password, true
		add_column :users, :name, :string, null: true
	end
end

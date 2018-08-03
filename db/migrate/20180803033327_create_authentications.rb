class CreateAuthentications < ActiveRecord::Migration[5.0]
  def change
		create_table :authentications do |t|
			t.string :provider, null: false
			t.string :uid, null: false
			t.string :token, null: false
			t.string :username, null: true
			t.belongs_to :user, null: false, foreign_key: true
			t.timestamps null: false
			t.index [:provider, :uid], unique: true
		end
  end
end

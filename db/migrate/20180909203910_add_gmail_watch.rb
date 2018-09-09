class AddGmailWatch < ActiveRecord::Migration[5.1]
  def change
    create_table :gmail_watches do |t|
      t.datetime :expires_at, null: false
      t.string :current_history_id, null: false
      t.string :email_address, null: false, index: true

      t.belongs_to :authentication, foreign_key: true, index: { unique: true }, null: false
    end
  end
end

class CreatePushNotificationRegistrations < ActiveRecord::Migration[5.2]
  def change
    create_table :push_notification_registrations do |t|
			t.belongs_to :user, null: false, index: true, foreign_key: true, unique: false
      t.text :endpoint, null: false
			t.text :p256dh, null: false
			t.text :auth, null: false

			t.index [:user_id, :endpoint, :p256dh, :auth], name: 'index_push_notification_registrations_on_everything', unique: true
      t.timestamps
    end
  end
end

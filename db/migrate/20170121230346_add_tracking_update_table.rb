# frozen_string_literal: true
class AddTrackingUpdateTable < ActiveRecord::Migration[5.0]
  def change
    create_table :tracking_update do |t|
      t.references :package, null: false, index: true, foreign_key: true
      t.text :message, null: false
      t.text :status, null: false
      t.datetime :tracking_updated_at, null: false, index: true

      t.text :city, null: true
      t.text :state, null: true
      t.text :country, null: true
      t.text :zip, null: true

      t.timestamps null: false
    end
    add_index(
      :tracking_update,
      [:package_id, :tracking_updated_at, :status],
      unique: true,
      name: 'index_tracking_update_on_uniqueness',
    )
  end
end

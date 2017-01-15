class AddEasyPostTrackingIdToPackages < ActiveRecord::Migration[5.0]
  def change
    add_column :packages, :easypost_tracking_id, :string, null: false
    add_index :packages, :easypost_tracking_id
  end
end

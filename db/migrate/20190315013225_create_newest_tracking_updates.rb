class CreateNewestTrackingUpdates < ActiveRecord::Migration[5.2]
  def change
    create_view :newest_tracking_updates
  end
end

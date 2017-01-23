class MakeTrackingUpatedAtNullableOnTrackingUpdate < ActiveRecord::Migration[5.0]
  def change
    change_column_null :tracking_updates, :tracking_updated_at, true
  end
end

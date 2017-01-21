class TrackingUpdate < ApplicationRecord
  belongs_to :package

  validates_uniqueness_of :package_id, :scope => [:status, :estimated_delivery_date]
end

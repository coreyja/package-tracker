# frozen_string_literal: true
class TrackingUpdate < ApplicationRecord
  belongs_to :package

  validates_uniqueness_of :package_id, scope: [:status, :tracking_updated_at]

  scope :newest_first, -> { order tracking_updated_at: :desc }
end

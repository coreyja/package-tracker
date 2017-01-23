# frozen_string_literal: true
class TrackingUpdate < ApplicationRecord
  belongs_to :package

  STATUS_OPTIONS = %i(
    unknown
    pre_transit
    in_transit
    out_for_delivery
    delivered
    available_for_pickup
    return_to_sender
    failure
    cancelled
    error
  ).freeze
  enum status: STATUS_OPTIONS.map { |x| [x, x.to_s] }.to_h

  validates_uniqueness_of :package_id, scope: [:status, :tracking_updated_at]

  scope :newest_first, -> { order tracking_updated_at: :desc }

  def display_status
    status.humanize
  end
end

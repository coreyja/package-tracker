# frozen_string_literal: true
class Package < ApplicationRecord
  belongs_to :user
  has_many :tracking_updates

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

  validates :name, :tracking_number, :carrier, :easypost_tracking_id, :status, presence: true
  validates! :user_id, presence: true

  def refresh_tracking!
    PackageTrackerUpdate.new(self, remote_tracker).perform!
  end

  def display_status
    status.humanize
  end

  def map_data
    tracking_updates.map(&:map_data).compact
  end

  private

  def remote_tracker
    EasyPost::Tracker.retrieve(easypost_tracking_id)
  end
end

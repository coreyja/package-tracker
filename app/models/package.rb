# frozen_string_literal: true

class Package < ApplicationRecord
  belongs_to :user
  has_many :tracking_updates, dependent: :destroy

  STATUS_OPTIONS = %i[
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
  ].freeze
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

  def order
    most_recent_update.to_i
  end

  def most_recent_update
    if tracking_updates.loaded?
      tracking_updates.select(&:tracking_updated_at?).min_by(&:tracking_updated_at).tracking_updated_at
    else
      tracking_updates.where.not(tracking_updated_at: nil).newest_first.first.tracking_updated_at
    end
  end

  private

  def remote_tracker
    EasyPost::Tracker.retrieve(easypost_tracking_id)
  end
end

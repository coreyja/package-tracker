# frozen_string_literal: true

class Package < ApplicationRecord
  belongs_to :user
  has_many :tracking_updates, dependent: :destroy
  has_one :most_recent_tracking_update,
          -> { with_tracking_updated_at.newest_first.limit(1) },
          class_name: 'TrackingUpdate'

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

  scope :archived, -> { where.not(archived_at: nil) }
  scope :unarchived, -> { where(archived_at: nil) }

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
    most_recently_updated_at.to_i
  end

  def most_recently_updated_at
    most_recent_tracking_update&.tracking_updated_at
  end

  def archive!
    update!(archived_at: Time.zone.now)
  end

  def archived?
    archived_at.present?
  end

  private

  def remote_tracker
    EasyPost::Tracker.retrieve(easypost_tracking_id)
  end
end

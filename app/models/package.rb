# frozen_string_literal: true

class Package < ApplicationRecord
  belongs_to :user
  has_many :tracking_updates, dependent: :destroy
  has_one :newest_tracking_update

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
  scope :arriving_on, ->(date) { where(estimated_delivery_date: date) }
  scope :not_arriving_on, ->(date) { where(estimated_delivery_date: nil).or(where.not(estimated_delivery_date: date)) }
  scope :delivered_after, ->(date) { delivered.joins(:tracking_updates).merge(TrackingUpdate.delivered_after(date)) }
  scope :not_delivered_on, ->(date) { joins(:tracking_updates).merge(TrackingUpdate.not_delivered_on(date)) }

  validates :name, :tracking_number, :carrier_code, :easypost_tracking_id, :status, presence: true
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
    newest_tracking_update&.tracking_updated_at
  end

  def archive!
    update!(archived_at: Time.zone.now)
  end

  def archived?
    archived_at.present?
  end

  def newest_tracking_update
    super&.becomes(TrackingUpdate)
  end

  def carrier
    @carrier ||= EasypostCarrier.all.find { |carrier| carrier.code.downcase == carrier_code.downcase }
  end

  private

  def remote_tracker
    EasyPost::Tracker.retrieve(easypost_tracking_id)
  end
end

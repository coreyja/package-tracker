# frozen_string_literal: true

class PackageTrackerUpdate
  using EasypostTrackerToPackage

  def initialize(package, tracker)
    @package = package
    @tracker = tracker
  end

  def perform!
    package.transaction do
      send_slack_update! if new_tracking_updates?
      package.update! tracker.to_package_attrs
      process_tracking_updates!
    end
  end

  private

  attr_reader :tracker, :package

  def process_tracking_updates!
    tracker.tracking_details.each do |tracking_detail|
      TrackingUpdatePerformer.new(package, tracking_detail).save!
    end
  end

  def send_slack_update!
    EasypostTrackerSlackPoster.new(package, tracker).post
  end

  def new_tracking_updates?
    package.tracking_updates.count == tracker.tracking_details.count
  end

  class TrackingUpdatePerformer
    def initialize(package, tracking_detail)
      @package = package
      @tracking_detail = tracking_detail
    end

    def save!
      tracking_update.update! tracking_update_params
    end

    private

    attr_reader :tracking_detail, :package

    def tracking_update_params
      {
        message: tracking_detail.message,
        city: tracking_detail.tracking_location.city,
        state: tracking_detail.tracking_location.state,
        country: tracking_detail.tracking_location.country,
        zip: tracking_detail.tracking_location.zip,
      }
    end

    def tracking_update
      @tracking_update = TrackingUpdate.find_or_initialize_by(
        package: package,
        status: tracking_detail.status,
        tracking_updated_at: tracking_detail.datetime,
      )
    end
  end
end

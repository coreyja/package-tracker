# frozen_string_literal: true

class EasypostEventPerformer
  module EasypostResourceRefinements
    refine EasyPost::Resource do
      def handle_event!
        nil
      end
    end

    refine EasyPost::Tracker do
      def handle_event!
        PackageTrackerUpdate.new(package, self).perform!
      end

      def package
        Package.find_by!(easypost_tracking_id: id)
      end
    end
  end
  using EasypostResourceRefinements

  def initialize(hash)
    @hash = hash
  end

  def perform
    result.handle_event!
  end

  private

  attr_reader :hash
  delegate :result, to: :event

  def event
    EasyPost::Util.convert_to_easypost_object(hash, Rails.application.secrets.easypost_api_key)
  end
end

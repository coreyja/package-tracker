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

  attr_reader :post_body

  def initialize(post_body)
    @post_body = post_body
  end

  def perform
    result.handle_event!
  end

  private

  delegate :result, to: :event

  def event
    @event ||= EasyPost::Util.convert_to_easypost_object(hash, Rails.application.secrets.easypost_api_key)
  end

  def hash
    @hash ||= JSON.parse(post_body).to_hash.deep_symbolize_keys
  end
end

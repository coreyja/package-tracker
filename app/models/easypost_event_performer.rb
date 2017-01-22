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
        EasypostTrackerSlackPoster.new(self).post
      end
    end
  end
  using EasypostResourceRefinements

  def initialize(event)
    @event = event
  end

  def perform!
    result.handle_event!
  end

  private

  attr_reader :event
  delegate :result, to: :event
end

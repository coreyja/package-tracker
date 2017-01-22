# frozen_string_literal: true
class Package < ApplicationRecord
  belongs_to :user

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

  def self.from_params(params)
    new Params.new(params).attrs
  end

  class Params
    module EasyPostTrackerRefinements
      refine EasyPost::Tracker do
        def to_package_attrs
          {
            tracking_number: tracking_code,
            carrier: carrier,
            easypost_tracking_id: id,
            status: status,
            estimated_delivery_date: est_delivery_date,
          }
        end
      end
    end
    using EasyPostTrackerRefinements

    def initialize(params = {})
      @params = params.to_h
    end

    def attrs
      params.merge(overrides).compact
    end

    private

    def overrides
      easypost_tracker.to_package_attrs
    end

    def tracking_number
      params[:tracking_number]
    end

    def carrier
      params[:carrier]
    end

    def easypost_tracker
      @easypost_tracker ||= EasyPost::Tracker.create(tracking_code: tracking_number, carrier: carrier)
    end

    attr_reader :params
  end
end

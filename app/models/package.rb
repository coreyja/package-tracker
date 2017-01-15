class Package < ApplicationRecord
  belongs_to :user

  validates :name, :tracking_number, :carrier, :easypost_tracking_id, presence: true
  validates! :user, presence: true

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
            easypost_tracking_id: id
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

    def easypost_tracker
      @easypost_tracker ||= EasyPost::Tracker.create(tracking_code: tracking_number)
    end

    attr_reader :params
  end
end

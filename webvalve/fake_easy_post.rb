# frozen_string_literal: true

class FakeEasyPost < WebValve::FakeService
  class << self
    attr_accessor :tracking_details_enabled, :est_delivery_date

    def event_details_json
      inner.event_details_json
    end

    def inner
      Inner.new(
        est_delivery_date: est_delivery_date,
        tracking_details_enabled: tracking_details_enabled?
      )
    end

    def tracking_details_enabled?
      if instance_variable_defined? :@tracking_details_enabled
        @tracking_details_enabled
      else
        true
      end
    end
  end

  def inner
    self.class.inner
  end

  post '/v2/trackers' do
    json inner.tracking_hash
  end

  class Inner
    attr_reader :tracking_details_enabled, :est_delivery_date

    def initialize(tracking_details_enabled: true, est_delivery_date: nil)
      @est_delivery_date = est_delivery_date
      @tracking_details_enabled = tracking_details_enabled
    end

    def event_details_json
      event_details_hash.to_json
    end

    def event_details_hash
      {
        'object' => 'Event',
        'result' => tracking_hash,
        'description' => 'tracker.updated',
        'mode' => 'test',
        'previous_attributes' => {
          'status' => 'unknown'
        },
        'created_at' => '2019-03-03T03:34:26Z',
        'pending_urls' => [],
        'completed_urls' => [],
        'updated_at' => '2019-03-03T03:34:26Z',
        'id' => 'evt_4f7328c1cab94dfdbc7fd2bfda2ba151',
        'user_id' => 'user_024c895e1c1a48c19c29c5fdcf197cac',
        'status' => 'in_queue'
      }
    end

    def tracking_hash
      {
        'id' => 'trk_c8e0edb5bb284caa934a0d3db23a148z',
        'object' => 'Tracker',
        'mode' => 'test',
        'tracking_code' => '9400110898825022579493',
        'status' => 'in_transit',
        'created_at' => '2016-01-13T21:52:28Z',
        'updated_at' => '2016-01-13T21:52:32Z',
        'signed_by' => nil,
        'weight' => nil,
        'est_delivery_date' => est_delivery_date&.iso8601,
        'shipment_id' => nil,
        'carrier' => 'USPS',
        'public_url' => 'https://track.easypost.com/djE6...',
        'tracking_details' => tracking_details,
        'carrier_detail' => nil,
        'fees' => [
          {
            'object' => 'Fee',
            'type' => 'TrackerFee',
            'amount' => '0.00000',
            'charged' => true,
            'refunded' => false
          }
        ]
      }
    end

    def tracking_details
      if tracking_details_enabled
        [
          {
            'object' => 'TrackingDetail',
            'message' => 'Shipping Label Created',
            'status' => 'pre_transit',
            'datetime' => '2015-12-31T15:58:00Z',
            'source' => 'USPS',
            'tracking_location' => {
              'object' => 'TrackingLocation',
              'city' => 'FOUNTAIN VALLEY',
              'state' => 'CA',
              'country' => nil,
              'zip' => '92708'
            }
          },
          {
            'object' => 'TrackingDetail',
            'message' => 'Arrived at Post Office',
            'status' => 'in_transit',
            'datetime' => '2016-01-07T06:58:00Z',
            'source' => 'USPS',
            'tracking_location' => {
              'object' => 'TrackingLocation',
              'city' => 'FOUNTAIN VALLEY',
              'state' => 'CA',
              'country' => nil,
              'zip' => '92728'
            }
          }
        ]
      else
        []
      end
    end
  end
end

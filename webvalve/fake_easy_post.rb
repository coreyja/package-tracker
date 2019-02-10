# frozen_string_literal: true

class FakeEasyPost < WebValve::FakeService
  @@tracking_details_enabled = true

  def self.tracking_details_enabled=(enabled = true)
    @@tracking_details_enabled = enabled
  end

  def self.tracking_details_enabled?
    @@tracking_details_enabled
  end

  post '/v2/trackers' do
    json tracking_hash
  end

  private

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
      'est_delivery_date' => nil,
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
    if self.class.tracking_details_enabled?
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

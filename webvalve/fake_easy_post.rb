class FakeEasyPost < WebValve::FakeService
  # # define your routes here
  #
  # get '/widgets' do
  #   json result: 'it works!'
  # end
  #
  # # set the base url for this API via ENV
  #
  # export EASYPOST_API_URL='http://whatever.dev'
  #
  # # toggle this service on via ENV
  #
  # export EASYPOST_ENABLED=true

  post '/v2/trackers' do
    json JSON.parse(<<~JSON)
      {
        "id": "trk_c8e0edb5bb284caa934a0d3db23a148z",
        "object": "Tracker",
        "mode": "test",
        "tracking_code": "9400110898825022579493",
        "status": "in_transit",
        "created_at": "2016-01-13T21:52:28Z",
        "updated_at": "2016-01-13T21:52:32Z",
        "signed_by": null,
        "weight": null,
        "est_delivery_date": null,
        "shipment_id": null,
        "carrier": "USPS",
        "public_url": "https://track.easypost.com/djE6...",
        "tracking_details": [
          {
            "object": "TrackingDetail",
            "message": "Shipping Label Created",
            "status": "pre_transit",
            "datetime": "2015-12-31T15:58:00Z",
            "source": "USPS",
            "tracking_location": {
              "object": "TrackingLocation",
              "city": "FOUNTAIN VALLEY",
              "state": "CA",
              "country": null,
              "zip": "92708"
            }
          },
          {
            "object": "TrackingDetail",
            "message": "Arrived at Post Office",
            "status": "in_transit",
            "datetime": "2016-01-07T06:58:00Z",
            "source": "USPS",
            "tracking_location": {
              "object": "TrackingLocation",
              "city": "FOUNTAIN VALLEY",
              "state": "CA",
              "country": null,
              "zip": "92728"
            }
          }
        ],
        "carrier_detail": null,
        "fees": [
          {
            "object": "Fee",
            "type": "TrackerFee",
            "amount": "0.00000",
            "charged": true,
            "refunded": false
          }
        ]
      }
    JSON
  end
end

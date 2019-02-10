# frozen_string_literal: true

class EasypostTrackerSlackPoster
  def initialize(package, tracker)
    @package = package
    @tracker = tracker
  end

  def post
    RestClient.post(Rails.application.secrets.slack_url, json.to_json, content_type: :json, accept: :json)
  end

  private

  attr_reader :package, :tracker

  def json
    {
      text: '',
      attachments: [
        {
          fields: [
            {
              title: 'Package Name',
              value: package.name,
              short: true
            },
            {
              title: 'Tracking Number',
              value: tracker.tracking_code,
              short: true
            },
            {
              title: 'Status',
              value: tracker.status,
              short: true
            },
            {
              title: 'Estimated Delivery Date',
              value: tracker.est_delivery_date,
              short: true
            },
            {
              title: 'Public Url',
              value: tracker.public_url,
              short: false
            }
          ]
        }
      ]
    }
  end
end

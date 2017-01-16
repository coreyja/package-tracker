class EasypostTrackerSlackPoster
  SLACK_URL = ENV['SLACK_POST_URL'].freeze

  def initialize(tracker)
    @tracker = tracker
  end

  def post
    RestClient.post(SLACK_URL, json.to_json, {content_type: :json, accept: :json})
  end

  private

  attr_reader :tracker

  def json
    {
      text: text,
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

  def text
    "```#{JSON.pretty_generate(tracker.to_h)}```"
  end

  def package
    Package.find_by!(easypost_tracking_id: tracker.id)
  end
end
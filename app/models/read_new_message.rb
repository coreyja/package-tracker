# frozen_string_literal: true

class ReadNewMessage
  CARRIER_CODES = {
    usps: 'USPS',
    ups: 'UPS',
    fedex: 'FedEx',
    dhl: 'DHLExpress'
	}

  def initialize(gmail_watch:, message_id:)
    @gmail_watch = gmail_watch
    @message_id = message_id
  end

  def perform
    return unless message.present?

    tracking_numbers.each do |tracking_number|
      Rails.logger.info tracking_number.tracking_number
      Rails.logger.info tracking_number.carrier_code
      Rails.logger.info tracking_number.carrier_name
      if CARRIER_CODES.key? tracking_number.carrier_code
        PackageCreator.new(
          name: message.subject,
          tracking_number: tracking_number.tracking_number,
          carrier: CARRIER_CODES.fetch(tracking_number.carrier_code),
          user: user
        ).save!
      end
    end
  end

  private

  attr_reader :gmail_watch, :message_id

  def user
    gmail_watch.authentication.user
  end

  def tracking_numbers
    @tracking_numbers ||= TrackingNumber.search message.joined_body
  end

  def message
    @message ||= GmailMessage.new(gmail_service: service, message_id: message_id)
  end

  def service
    @service ||= gmail_watch.authentication.gmail_service
  end
end

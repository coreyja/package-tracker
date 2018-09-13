# frozen_string_literal: true

class ReadNewMessage
  CARRIER_CODES = {
    usps: 'USPS',
    ups: 'UPS',
    fedex: 'FedEx',
    dhl: 'DHLExpress'
  }.freeze

  def initialize(gmail_watch:, message_id:)
    @gmail_watch = gmail_watch
    @message_id = message_id
  end

  def perform
    return unless message.present?

    valid_tracking_numbers.each do |tracking_number|
      Rails.logger.info tracking_number.tracking_number
      Rails.logger.info tracking_number.carrier_code
      Rails.logger.info tracking_number.carrier_name
    end
  end

  private

  attr_reader :gmail_watch, :message_id

  def user
    gmail_watch.authentication.user
  end

  def valid_tracking_numbers
    tracking_numbers.select do |tracking_number|
      CARRIER_CODES.key? tracking_number.carrier_code
    end
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

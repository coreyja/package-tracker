# frozen_string_literal: true

class ReadNewMessage
  def initialize(gmail_watch:, message_id:)
    @gmail_watch = gmail_watch
    @message_id = message_id
  end

  def perform
    return unless message.present?

    tracking_numbers.each do |tracking_number|
      PackageCreator.new(
        name: message.subject,
        tracking_number: tracking_number.tracking_number,
        carrier: tracking_number.carrier
      ).save!
    end
  end

  private

  attr_reader :gmail_watch, :message_id

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

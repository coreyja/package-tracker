# frozen_string_literal: true

class ReadNewMessage
  def initialize(gmail_watch:, message_id:)
    @gmail_watch = gmail_watch
    @message_id = message_id
  end

  def perform
    p "Reading email for #{gmail_watch.email_address} #{message_id}"
    if message.present?
      Rails.logger.info "Email Found! Subject: #{message.subject} Body Length: #{message.body.length}"
    else
      Rails.logger.error "No message matching id found. #{gmail_watch.email_address} Message ID: #{message_id}"
    end
  end

  private

  attr_reader :gmail_watch, :message_id

  def message
    @message ||= GmailMessage.new(gmail_service: service, message_id: message_id)
  end

  def service
    @service ||= gmail_watch.authentication.gmail_service
  end
end

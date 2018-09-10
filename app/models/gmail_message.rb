# frozen_string_literal: true

class GmailMessage
  def initialize(gmail_service:, message_id:)
    @gmail_service = gmail_service
    @message_id = message_id
  end

  def subject
    message.payload.headers.find { |header| header.name == 'Subject' }&.value
  end

  def bodies
    ([message.payload.body.data] + message_parts.map(&:body).map(&:data)).compact
  end

  def joined_body
    bodies.join(' ')
  end

  def present?
    message.present?
  end

  private

  attr_reader :gmail_service, :message_id

  def selected_part_body
    text_part_body || html_part_body
  end

  def message_parts
    message.payload.parts || []
  end

  def plain_part
    @plain_part ||= message.payload.parts.find { |x| x.mime_type == 'text/plain' }
  end

  def message
    @message ||= gmail_service.get_user_message 'me', message_id
  rescue Google::Apis::ClientError
    nil
  end
end

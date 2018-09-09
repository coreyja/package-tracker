class GmailMessage
  def initialize(gmail_service:, message_id:)
    @gmail_service = gmail_service
    @message_id = message_id
  end

  def body
    if !message.payload.body.size.zero?
      message.payload.body.data
    elsif plain_part.present?
      plain_part.body.data
    else
      message.payload.parts.first.body.data
    end
  end

  def present?
    message.present?
  end

  private

  attr_reader :gmail_service, :message_id

  def selected_part_body
    text_part_body || html_part_body
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

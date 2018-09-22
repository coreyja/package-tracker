# frozen_string_literal: true

class ReadNewHistory
  def initialize(email_address:)
    @email_address = email_address
  end

  def perform
    read_messages
    gmail_watch.update!(current_history_id: most_recent_history_id)
  end

  private

  attr_reader :email_address

  def read_messages
    message_ids.each do |id|
      Delayed::Job.enqueue ReadNewMessage.new(gmail_watch: gmail_watch, message_id: id)
    end
  end

  def message_ids
    if histories.history.present?
      histories.history.flat_map(&:messages).map(&:id).uniq
    else
      []
    end
  end

  def most_recent_history_id
    if histories.history.present?
      histories.history.map(&:id).max
    else
      start_reading_at
    end
  end

  def histories
    @histories ||= service.list_user_histories 'me', history_types: ['messageAdded'], start_history_id: start_reading_at
  end

  def gmail_watch
    @gmail_watch ||= GmailWatch.find_by!(email_address: email_address)
  end

  def start_reading_at
    gmail_watch.current_history_id
  end

  def service
    @service ||= authentication.gmail_service
  end

  def authentication
    gmail_watch.authentication
  end
end

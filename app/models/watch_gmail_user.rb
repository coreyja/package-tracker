# frozen_string_literal: true

class WatchGmailUser
  def initialize(authentication_id)
    @authentication_id = authentication_id
  end

  def perform
    response = service.watch_user('me', watch_request)
    gmail_watch.update!(
      expires_at: Time.at(response.expiration / 1000.0),
      current_history_id: response.history_id
    )
  end

  private

  attr_reader :authentication_id

  def watch_request
    Google::Apis::GmailV1::WatchRequest.new topic_name: ENV.fetch('PUBSUB_TOPIC')
  end

  def gmail_watch
    authentication.gmail_watch || GmailWatch.new(authentication: authentication, email_address: email_address)
  end

  def email_address
    service.get_user_profile('me').email_address
  end

  def service
    @service ||= authentication.gmail_service
  end

  def authentication
    @authentication ||= Authentication.find(authentication_id)
  end
end

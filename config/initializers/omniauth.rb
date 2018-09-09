require 'google/apis/gmail_v1'
Rails.application.config.middleware.use OmniAuth::Builder do
	provider :google_oauth2, ENV['GOOGLE_CLIENT_ID'], ENV['GOOGLE_CLIENT_SECRET'],
		scope: ['profile', Google::Apis::GmailV1::AUTH_GMAIL_READONLY],
    access_type: 'offline'
end

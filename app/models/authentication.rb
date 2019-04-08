# frozen_string_literal: true

class Authentication < ApplicationRecord
  belongs_to :user
  has_one :gmail_watch

  def self.find_or_create_by_omniauth!(auth_hash, current_user: nil)
    find_or_create_by!(provider: auth_hash.provider, uid: auth_hash.uid) do |authentication|
      authentication.user = current_user || User.find_or_create_by_omniauth!(auth_hash)
      authentication.token = auth_hash.credentials.token
      authentication.expires_at = Time.at(auth_hash.credentials.expires_at)
      authentication.refresh_token = auth_hash.credentials.refresh_token
    end
  end

  def update_token!(auth_hash)
    update!(
      token: auth_hash['credentials']['token'],
      expires_at: Time.at(auth_hash['credentials']['expires_at'])
    )
  end

  def expired?
    !(expires_at.nil? || expires_at > Time.zone.now)
  end

  def refresh_google_oauth_token!
    raise 'Must be google_oauth2' unless provider.to_s == 'google_oauth2'

    access_token = oauth_access_token.refresh!
    update!(
      token: access_token.token,
      expires_at: Time.at(access_token.expires_at)
    )
  end

  def valid_token
    refresh_google_oauth_token! if expired?
    token
  end

  def gmail_service
    @gmail_service ||= Google::Apis::GmailV1::GmailService.new.tap do |service|
      service.authorization = Signet::OAuth2::Client.new(access_token: valid_token)
    end
  end

  private

  def omni_auth_stratgey_class
    OmniAuth::Strategies.const_get(OmniAuth::Utils.camelize(provider).to_s)
  end

  def oauth_access_token
    client = omni_auth_stratgey_class.new(nil, ENV['GOOGLE_CLIENT_ID'], ENV['GOOGLE_CLIENT_SECRET']).client
    OAuth2::AccessToken.from_hash client, attributes
  end
end

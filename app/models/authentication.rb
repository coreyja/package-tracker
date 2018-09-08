# frozen_string_literal: true

class Authentication < ApplicationRecord
  belongs_to :user

  def self.find_or_create_by_omniauth!(auth_hash, current_user: nil)
    find_or_create_by!(provider: auth_hash.provider, uid: auth_hash.uid) do |authentication|
      authentication.user = current_user || User.find_or_create_by_omniauth!(auth_hash)
      authentication.token = auth_hash.credentials.token
    end
  end

  def update_token!(auth_hash)
    update! token: auth_hash['credentials']['token']
  end
end

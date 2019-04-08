# frozen_string_literal: true

class User < ApplicationRecord
  include Clearance::User

  has_many :packages
  has_many :authentications, dependent: :destroy
  has_many :push_notification_registrations

  def self.find_or_create_by_omniauth!(auth_hash)
    find_or_create_by!(email: auth_hash.info.email) do |user|
      user.name = auth_hash.info.name
    end
  end

  def password_optional?
    authentications.any?
  end
end

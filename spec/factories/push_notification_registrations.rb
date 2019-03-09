# frozen_string_literal: true

FactoryBot.define do
  factory :push_notification_registration do
    endpoint { 'https://webpush.endpoint' }
    p256dh { 'BN4GvZtEZiZuqFxSKVZfSfluwKBD7UxHNBmWkfiZfCtgDE8Bwh-_MtLXbBxTBAWH9r7IPKL0lhdcaqtL1dfxU5E=' }
    auth { SecureRandom.base64 }
  end
end

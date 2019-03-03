# frozen_string_literal: true

class PushNotificationRegistration < ApplicationRecord
  belongs_to :user

  def send_push(title, options: {})
    Webpush.payload_send(push_hash.merge(message: { title: title }.merge(options).to_json))
  rescue Webpush::ExpiredSubscription
    destroy!
  end

  private

  def push_hash
    {
      endpoint: endpoint,
      p256dh: p256dh,
      auth: auth,
      vapid: Vapid.to_hash
    }
  end
end

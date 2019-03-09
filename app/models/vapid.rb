# frozen_string_literal: true

module Vapid
  module_function

  def to_hash
    {
      subject: 'mailto:sender@example.com',
      public_key: Rails.application.secrets.vapid_public_key,
      private_key: Rails.application.secrets.vapid_private_key
    }
  end
end

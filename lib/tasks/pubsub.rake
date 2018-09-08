# frozen_string_literal: true

namespace :pubsub do
  desc 'Create the Pub/Sub Subscription if it does not already exist'
  task createSub: :environment do
    require 'google/cloud/pubsub'

    pubsub = Google::Cloud::Pubsub.new
    topic = pubsub.topic ENV.fetch('PUBSUB_TOPIC')
    endpoint = Rails.application.routes.url_helpers.api_pubsub_messages_url(host: ENV.fetch('APPLICATION_BASE_URL'))

    subscription_name = ENV.fetch('PUBSUB_SUB_NAME')

    sub = topic.subscription subscription_name

    if sub.present?
      sub.endpoint = endpoint
    else
      topic.subscribe subscription_name, endpoint: endpoint
    end
  end
end

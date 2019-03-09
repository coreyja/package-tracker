# frozen_string_literal: true

FactoryBot.define do
  factory :package do
    user
    name { 'Package Name' }
    tracking_number { '1234' }
    carrier { 'USPS' }
    easypost_tracking_id { 'FAKE_TRACKER_ID' }
    status { 'unknown' }
  end
end

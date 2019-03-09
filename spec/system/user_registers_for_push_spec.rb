# frozen_string_literal: true

require 'rails_helper'
require 'support/system/clearance_helpers'

RSpec.describe 'User registers for Push Notifications' do
  it 'works' do
    user = FactoryBot.create(:user, password: 'password')

    sign_in_with(user.email, 'password')

    visit my_push_notification_registrations_path
    expect(page).to have_content 'Push Notification Registrations'
  end
end

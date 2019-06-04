# frozen_string_literal: true

require 'rails_helper'
require 'support/system/clearance_helpers'

RSpec.describe 'User views dashboard' do
  it 'user views dashboard' do
    sign_in

    visit root_path
    expect(page).to have_content I18n.t('dashboard.empty.title')

    FakeEasyPost.est_delivery_date = Time.zone.today
    add_new_package name: 'Cool Stuff from Amazon'

    visit root_path
    expect(page).to have_link I18n.t('dashboard.add_button')
    expect(page).not_to have_content I18n.t('dashboard.empty.title')

    expect(page).to have_content I18n.t('dashboard.arriving_today_title', number: 1)
    expect(page).to have_content 'Cool Stuff from Amazon'

    FakeEasyPost.est_delivery_date = 1.days.from_now
    add_new_package name: 'Stuff Arriving Later'
    visit root_path
    expect(page).to have_link I18n.t('dashboard.add_button')
    expect(page).to have_content I18n.t('dashboard.arriving_today_title', number: 1)
    expect(page).not_to have_content 'Stuff Arriving Later'
  end

  def add_new_package(name: 'Test Package', number: '1234', carrier: 'USPS')
    click_on I18n.t('dashboard.add_button')

    fill_in 'Name', with: name
    fill_in 'Tracking number', with: number
    fill_in 'Carrier', with: carrier

    click_on 'Create Package'
  end
end

# frozen_string_literal: true

require 'rails_helper'
require 'support/system/clearance_helpers'

RSpec.describe 'User views packages' do
  it 'works' do
    user = FactoryBot.create(:user, password: 'password')

    sign_in_with(user.email, 'password')

    visit my_packages_path
    has_no_package_rows

    add_new_package
    has_expected_number_of_package_rows(count: 1)

    FakeEasyPost.tracking_details_enabled = false

    add_new_package(name: 'Custom Name')
    has_expected_number_of_package_rows(count: 2)
    has_package_row_with_text 'Custom Name'
  end

  def has_expected_number_of_package_rows(count:)
    table = page.find('table', text: /Name.*Status/)
    expect(table).to have_css('tbody tr', count: count)
  end

  def has_package_row_with_text(text)
    table = page.find('table', text: /Name.*Status/)
    expect(table).to have_css('tbody tr', text: text)
  end

  def has_no_package_rows
    has_expected_number_of_package_rows(count: 0)
  end

  def add_new_package(name: 'Test Package', number: '1234', carrier: 'USPS')
    click_on 'Add New'

    fill_in 'Name', with: name
    fill_in 'Tracking number', with: number
    fill_in 'Carrier', with: carrier

    click_on 'Create Package'
  end
end

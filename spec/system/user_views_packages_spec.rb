# frozen_string_literal: true

require 'rails_helper'
require 'support/system/clearance_helpers'

RSpec.describe 'User views packages' do
  it 'works' do
    user = FactoryBot.create(:user, password: 'password')

    sign_in_with(user.email, 'password')

    visit my_packages_path
    has_no_package_rows

    click_on 'Add New'

    fill_in 'Name', with: 'Test Package'
    fill_in 'Tracking number', with: '1234'
    fill_in 'Carrier', with: 'USPS'

    click_on 'Create Package'

    has_expected_number_of_package_rows(count: 1)
  end

  def has_expected_number_of_package_rows(count:)
    table = page.find('table', text: /Name.*Status/)
    expect(table).to have_css('td', count: count)
  end

  def has_no_package_rows
    has_expected_number_of_package_rows(count: 0)
  end
end

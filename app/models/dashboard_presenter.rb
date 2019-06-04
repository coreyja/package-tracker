# frozen_string_literal: true

class DashboardPresenter
  def initialize(user:)
    @user = user
  end

  def packages_arriving_today
    unarchived_packages.arriving_on(Time.zone.today)
  end

  def packages_delivered_recently
    unarchived_packages.delivered_after(3.days.ago).not_delivered_on(Time.zone.today)
  end

  def packages_in_transit
    unarchived_packages.not_arriving_on(Time.zone.today).in_transit
  end

  def empty?
    packages_arriving_today.none? &&
      packages_delivered_recently.none? &&
      packages_in_transit.none?
  end

  private

  attr_reader :user

  def unarchived_packages
    user.packages.unarchived
  end
end

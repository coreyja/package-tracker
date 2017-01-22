# frozen_string_literal: true
class PackageCreator
  include ActiveModel::Model

  attr_accessor :user, :name, :tracking_number, :carrier

  validates :name, :tracking_number, :carrier, presence: true

  def save
    valid? && save!
  end

  def save!
    PackageTrackerUpdate.new(package, tracker).perform!
  end

  private

  def tracker
    @tracker = EasyPost::Tracker.create(tracking_code: tracking_number, carrier: carrier)
  end

  def package
    Package.new user: user, name: name
  end
end

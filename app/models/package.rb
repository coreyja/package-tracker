class Package < ApplicationRecord
  belongs_to :user

  validates :name, :tracking_number, :carrier, presence: true
  validates! :user, presence: true
end

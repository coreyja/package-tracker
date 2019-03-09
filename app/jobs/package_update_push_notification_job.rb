# frozen_string_literal: true

class PackageUpdatePushNotificationJob < ApplicationJob
  def perform(package)
    package.user.push_notification_registrations.each do |reg|
      reg.send_push(push_title(package),
                    options: {
                      body: push_body(package),
                      data: { path: "/my/packages/#{package.id}" },
                      actions: [{ title: 'View Package', action: 'open-path' }]
                    })
    end
  end

  private

  def push_title(package)
    "Package Update: #{package.name}"
  end

  def push_body(package)
    <<~BODY
      Status: #{package.status}
      Estimated Delivery: #{package.estimated_delivery_date}
    BODY
  end
end

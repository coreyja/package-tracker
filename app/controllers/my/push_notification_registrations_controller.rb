# frozen_string_literal: true

module My
  class PushNotificationRegistrationsController < ApplicationController
    before_action :require_login

    def index
      @vapid_public_key = Rails.application.secrets.vapid_public_key
    end

    def create
      current_user.push_notification_registrations.find_or_create_by!(registration_params)
    end

    private

    def registration_params
      {
        endpoint: subscription_params[:endpoint],
        p256dh: subscription_params[:keys][:p256dh],
        auth: subscription_params[:keys][:auth]
      }
    end

    def subscription_params
      params.require(:subscription).permit(:endpoint, keys: %i[auth p256dh])
    end
  end
end

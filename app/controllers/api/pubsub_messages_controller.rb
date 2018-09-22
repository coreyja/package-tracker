# frozen_string_literal: true

module Api
  class PubsubMessagesController < ApplicationController
    skip_before_action :verify_authenticity_token, only: :create

    def create
      Rails.logger.info decoded_message
      # ReadNewHistory.new(email_address: decoded_message['emailAddress']).perform
      head :no_content
    end

    private

    def decoded_message
      JSON.parse Base64.decode64(create_params[:message][:data])
    end

    def create_params
      params.permit(:subscription, message: %i[message_id data])
    end
  end
end

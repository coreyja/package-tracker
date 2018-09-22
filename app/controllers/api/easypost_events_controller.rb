# frozen_string_literal: true

module Api
  class EasypostEventsController < ApplicationController
    skip_before_action :verify_authenticity_token, only: :create

    def create
      Delayed::Job.enqueue EasypostEventPerformer.new(easypost_event)
      head :no_content
    end

    private

    def easypost_event
      EasyPost::Util.convert_to_easypost_object(params.to_h, nil)
    end

    def params
      super.tap(&:permit!)
    end
  end
end

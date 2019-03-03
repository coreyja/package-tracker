# frozen_string_literal: true

module Api
  class EasypostEventsController < ApplicationController
    skip_before_action :verify_authenticity_token, only: :create

    def create
      Delayed::Job.enqueue EasypostEventPerformer.new(params.to_h.deep_symbolize_keys)
      head :no_content
    end

    private

    def params
      super.tap(&:permit!)
    end
  end
end

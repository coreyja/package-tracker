# frozen_string_literal: true

module Api
  class EasypostEventsController < ApplicationController
    skip_before_action :verify_authenticity_token, only: :create

    def create
      Delayed::Job.enqueue EasypostEventPerformer.new(request.raw_post)
      head :no_content
    end
  end
end

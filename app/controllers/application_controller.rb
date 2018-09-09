# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Clearance::Controller
  protect_from_forgery with: :exception
  before_action :set_raven_context

  private

  def set_raven_context
    Raven.user_context(id: current_user&.id) # or anything else in session
    Raven.extra_context(params: raven_params, url: request.url)
  end

  def raven_params
    if params.respond_to?(:to_unsafe_h)
      params.to_unsafe_h
    else
      params.to_h
    end
  end
end

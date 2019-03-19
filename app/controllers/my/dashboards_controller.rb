# frozen_string_literal: true

module My
  class DashboardsController < ApplicationController
    before_action :require_login

    def show
      @dashboard = DashboardPresenter.new(user: current_user)
    end
  end
end

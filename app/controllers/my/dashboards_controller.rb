# frozen_string_literal: true

class My::DashboardsController < ApplicationController
  before_action :require_login

  def show
    @dashboard = DashboardPresenter.new(user: current_user)
  end
end

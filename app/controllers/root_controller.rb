# frozen_string_literal: true

class RootController < ApplicationController
  def index
    redirect_to my_dashboard_path
  end
end

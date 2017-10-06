# frozen_string_literal: true

module My
  class TrackingRefreshesController < ApplicationController
    def create
      package = current_user.packages.find params[:package_id]
      package.refresh_tracking!
      redirect_to my_package_path(package)
    end
  end
end

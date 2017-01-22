# frozen_string_literal: true
module My
  class PackagesController < ApplicationController
    def new
      @package = Package.new
    end

    def create
      @package = Package.from_params pendant_params
      if @package.save
        redirect_to my_packages_path
      else
        render :new
      end
    end

    def index
      @packages = current_user.packages
    end

    private

    def pendant_params
      params.require(:package).permit(:name, :tracking_number, :carrier).merge(user: current_user)
    end
  end
end

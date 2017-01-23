# frozen_string_literal: true
module My
  class PackagesController < ApplicationController
    def new
      @package_creator = PackageCreator.new
    end

    def create
      @package_creator = PackageCreator.new package_creator_params
      if @package_creator.save
        redirect_to my_packages_path
      else
        render :new
      end
    end

    def index
      @packages = current_user.packages.sort_by(&:order).reverse
    end

    def show
      @package = current_user.packages.find params[:id]
    end

    private

    def package_creator_params
      params.require(:package_creator).permit(:name, :tracking_number, :carrier).merge(user: current_user)
    end
  end
end

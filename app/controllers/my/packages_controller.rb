# frozen_string_literal: true

module My
  class PackagesController < ApplicationController
    before_action :require_login

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
      @show_archived = ActiveRecord::Type::Boolean.new.deserialize(params[:show_archived])

      package_relation = current_user.packages
      package_relation = package_relation.unarchived unless @show_archived
      @packages = package_relation.includes(:newest_tracking_update).sort_by(&:order).reverse
    end

    def show
      @package = current_user.packages.find params[:id]
    end

    private

    def package_creator_params
      params.require(:package_creator).permit(:name, :tracking_number, :carrier_code).merge(user: current_user)
    end
  end
end

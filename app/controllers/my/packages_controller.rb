module My
  class PackagesController < ApplicationController

    def new
      @package = Package.new
    end

    def create
      @package = Package.new pendant_attrs
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

    def pendant_attrs
      params.require(:package).permit(:name, :tracking_number, :carrier).merge(user: current_user)
    end
  end
end


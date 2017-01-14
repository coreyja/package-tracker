module My
  class PackagesController < ApplicationController

    def new
      @package = Package.new
    end

    def create
      @package = Package.new pendant_attrs
      @package.save!
      redirect_to root_path
    end

    private

    def pendant_attrs
      params.require(:package).permit(:name, :tracking_numner, :carrier).merge(user: current_user)
    end
  end
end


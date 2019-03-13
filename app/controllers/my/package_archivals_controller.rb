
# frozen_string_literal: true

class My::PackageArchivalsController < ApplicationController
  def create
    package = current_user.packages.find params[:package_id]
    package.archive!

    redirect_to my_packages_path
  end
end

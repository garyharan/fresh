class Admin::ProfilesController < ApplicationController
  def index
    @profiles = Profile.page(params[:page]).per(10)
  end
end

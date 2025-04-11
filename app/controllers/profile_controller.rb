class ProfileController < ApplicationController
  def show
    @profile = Current.session.user.profile
  end
end

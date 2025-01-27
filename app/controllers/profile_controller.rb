class ProfileController < ApplicationController
  def show
    @profile = Profile.find(Current.session.user.id)
  end
end

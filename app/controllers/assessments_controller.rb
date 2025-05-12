class AssessmentsController < ApplicationController
  def create
    @profile  = Profile.find(params[:profile_id])
    @assessment = Assessment.create! from_profile: Current.user.profile, to_profile: @profile, kind: params[:kind]
    @profiles = Profile.recommended(Current.user.profile).limit(1)

    if @assessment.reciprocated? && @assessment.kind == 'liked'
      @room = Room.find_or_create_by_profiles([@assessment.from_profile, @assessment.to_profile])

      render turbo_stream: turbo_stream.replace('discovery', partial: 'profiles/matched')
    else
      render turbo_stream: turbo_stream.replace('discovery', partial: 'profiles/index')
    end
  end
end

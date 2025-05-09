class TransferLikesAndPassesToAssessments < ActiveRecord::Migration[8.0]
  def up
    Like.all.each do |like|
      Assessment.create(from_profile: like.user.profile, to_profile: like.profile, kind: :liked)
    end

    Pass.all.each do |pass|
      Assessment.create(from_profile: pass.user.profile, to_profile: pass.profile, kind: :passed)
    end

    Like.all.destroy_all
    Pass.all.destroy_all
  end

  def down
    Assessment.where(kind: :liked).each do |assessment|
      Like.create(user: assessment.from_profile.user, profile: assessment.to_profile)
    end

    Assessment.where(kind: :passed).each do |assessment|
      Pass.create(user: assessment.from_profile.user, profile: assessment.to_profile)
    end

    Assessment.where(kind: [:liked, :passed]).destroy_all
  end
end

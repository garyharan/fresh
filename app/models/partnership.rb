class Partnership < ApplicationRecord
  enum :status, { unconfirmed: 0, confirmed: 1 }

  belongs_to :from_profile, class_name: "Profile"
  belongs_to :to_profile, class_name: "Profile"

  validates :from_profile_id, uniqueness: { scope: :to_profile_id }

  after_create :confirm_if_reciprocated
  after_destroy :downgrade_reciprocal

  def reciprocal
    self.class.find_by(from_profile: to_profile, to_profile: from_profile)
  end

  private

  def confirm_if_reciprocated
    if (other = reciprocal)
      other.update!(status: :confirmed)
      update!(status: :confirmed)
    end
  end

  def downgrade_reciprocal
    if (other = reciprocal)
      other.update!(status: :unconfirmed)
    end
  end
end

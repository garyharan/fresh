class Partnership < ApplicationRecord
  belongs_to :profile
  belongs_to :partner, class_name: 'Profile'

  def reciprocated?
    partner.partnerships.where(partner: profile).exists?
  end
end

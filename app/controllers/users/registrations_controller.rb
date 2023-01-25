# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  after_action :save_inviter, only: [:create]

  layout "authentication"

  private

  def save_inviter
    if session[:invite_code]
      inviter = User.find_by(invite_code: session[:invite_code])
      resource.update(inviter_id: inviter.id) if inviter.present?
    end
  end
end

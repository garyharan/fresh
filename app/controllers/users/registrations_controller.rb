# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  after_action :save_inviter, only: [:create]

  layout "authentication"

  private

  def save_inviter
    resource.update(inviter_id: session[:inviter_id])
  end
end

class NotificationTokensController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    Current.user.notification_tokens.find_or_create_by!(notification_token_params)
    head :created
  end

  private

  def notification_token_params
    params.require(:notification_token).permit(:token, :platform)
  end
end

class NewMessageNotifier < ApplicationNotifier
  required_param :message

  deliver_by :ios do |config|
    config.device_tokens = -> {
      recipient.notification_tokens.where(platform: :iOS).pluck(:token)
    }

    credentials = Rails.application.credentials.apns
    config.bundle_identifier = credentials.bundle_identifier
    config.key_id            = credentials.key_id
    config.team_id           = credentials.team_id
    config.apns_key          = credentials.apns_key

    config.development       = Rails.env.local?

    config.format = -> (apn) {
      message = params[:message]
      sender  = message.user

      apn.alert = "You received a message from #{sender.profile.display_name}!"

      apn.custom_payload = {
        path: room_url(message.room)
      }
    }

    config.after_delivery = lambda do |notification, delivery_info|
      Rails.logger.info "APNs delivery info: #{delivery_info.inspect}"
    end
  end
end

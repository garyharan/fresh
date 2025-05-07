require 'apnotic'

namespace :apns do
  desc "Test APNS sending"
  task test: :environment do
    connection = Apnotic::Connection.new(
      url: Apnotic::APPLE_DEVELOPMENT_SERVER_URL,
      auth_method: :token,
      cert_path: "AuthKey_QKJ7BW9MR7.p8",
      key_id: "QKJ7BW9MR7",
      team_id: "225PMG4CTU"
    )

    user = User.find_by(email_address: "gary.haran@gmail.com")
    notification_token = user.notification_tokens.last

    notification       = Apnotic::Notification.new(notification_token.token)
    notification.alert = "Notification from Apnotic!"
    notification.topic = "com.garyharan.FreshDating"

    push = connection.prepare_push(notification)
    push.on(:response) do |response|
      response.ok?      # => true
      response.status   # => '200'
      response.headers  # => {":status"=>"200", "apns-id"=>"6f2cd350-bfad-4af0-a8bc-0d501e9e1799"}
      response.body     # => ""
      puts response.inspect
    end

    connection.push_async(push)

    connection.join(timeout: 5)

    connection.close
  end
end

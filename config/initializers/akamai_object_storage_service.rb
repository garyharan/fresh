# because SSL cert shit doesn't work by default with non AWS servers
Aws.config.update(
  ssl_verify_peer: false,
  endpoint: Rails.application.credentials.dig(:akamai, Rails.env, :endpoint)
)

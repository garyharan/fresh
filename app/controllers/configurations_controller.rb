class ConfigurationsController < ApplicationController
  allow_unauthenticated_access

  def ios_v1
    render json: {
      settings: {},
      rules: [
        {
          patterns: ["/rooms/[0-9]+"],
          properties: { view_controller: "chat" }
        },
        {
          patterns: [
            ".*",
            "/profiles$"
          ],
          properties: { context: "default", push_to_refresh_enabled: "true" }
        },
        {
          patterns: ["/session/new$", "/users/new$"],
          properties: { context: "modal" }
        }
      ]
    }
  end
end

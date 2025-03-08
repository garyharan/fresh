class ConfigurationsController < ApplicationController
  allow_unauthenticated_access

  def ios_v1
    render json: {
      settings: {},
      rules: [
        {
          patterns: [
            ".*",
            "/profile$",
            "/profiles$",
            "/settings$",
            "/rooms/$",
          ],
          properties: {
            view_controller: "tab_bar",
            pull_to_refresh_enabled: "true"
          }
        },
        {
          patterns: [
            "/$",
            "/session/new$",
            "/users/new$",
            "/onboarding/.*"
          ],
          properties: {
            view_controller: "onboarding",
            pull_to_refresh_enabled: "true"
          }
        },
        {
          patterns: [
            "/rooms/[0-9]+"
          ],
          properties: {
            view_controller: "chat"
          }
        },
        {
          patterns: [
            "/session$"
          ],
          properties: {
            view_controller: "logout"
          }
        }
      ]
    }
  end
end

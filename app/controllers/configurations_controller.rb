class ConfigurationsController < ApplicationController
  allow_unauthenticated_access

  def ios_v1
    render json: {
      settings: {},
      rules: [
        {
          "patterns": ["/recede_historical_location"],
          "properties": {"presentation": "pop"}
        },
        {
          "patterns": ["/resume_historical_location"],
          "properties": {"presentation": "none"}
        },
        {
          "patterns": ["/refresh_historical_location"],
          "properties": {"presentation": "refresh"}
        },
        {
          patterns: [
            "/profiles$"
          ],
          properties: {
            presentation: "replace_root"
          }
        },
        {
          patterns: [
            "/profiles/[0-9]+/edit"
          ],
          properties: {
            context: "modal",
            modal_stye: "full"
          }
        },
        {
          patterns: [
            "/settings"
          ],
          properties: {
            context: "modal"
          }
        },
        {
          patterns: [
            "/session/new",
            "/users/new"
          ],
          properties: {
            context: "modal",
            modal_style: "full"
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
            "/onboarding/.*",
            "/profiles/new"
          ],
          properties: {
            context: "modal",
            presentation: "replace",
            modal_style: "large"
          }
        }
      ]
    }
  end
end

class ConfigurationsController < ApplicationController
  allow_unauthenticated_access

  def ios_v1
    render json: {
      settings: {},
      rules: [
        {
          patterns: [
            "/profiles$"
          ],
          properties: {}
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
            "/profiles/[0-9]+/edit",
            "/profiles/[0-9]+/images",
            "/session/new",
            "/users/new",
            "/cards",
            "/cards/.*",
            "/about"
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

  def android_v1
    render json: {
      settings: {},
      rules: [
        {
          patterns: [
            "/profiles$",
            "/profile$",
            "/rooms$"
          ],
          properties: {
            pull_to_refresh_enabled: true
          },
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
            "/profiles/[0-9]+/edit",
            "/profiles/[0-9]+/images",
            "/session/new",
            "/users/new",
            "/cards",
            "/cards/.*",
            "/about"
          ],
          properties: {
            context: "modal",
            modal_style: "full",
            pull_to_refresh_enabled: true
          }
        },
        # {
        #   patterns: [
        #     "/rooms/[0-9]+"
        #   ],
        #   properties: {
        #     title: "Chat",
        #     # uri: "hotwire://fragment/chat",
        #     context: "modal" # Will change when merged: https://github.com/hotwired/hotwire-native-android/pull/139
        #   }
        # },
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

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
            "/settings",
            "/profiles/[0-9]+"
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
            "/users/[0-9]+",
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
            "/settings",
            "/profiles/[0-9]+"
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
            "/users/[0-9]+",
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

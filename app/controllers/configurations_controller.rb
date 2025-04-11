class ConfigurationsController < ApplicationController
  allow_unauthenticated_access

  def ios_v1
    render json: {
      settings: {},
      rules: [
        {
          patterns: [
            "/profiles"
          ],
          properties: {
            presentation: "replace_root"
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
            context: "modal"
          }
        },
        {
          patterns: [
            "/rooms/[0-9]+"
          ],
          properties: {
            view_controller: "chat"
          }
        }
      ]
    }
  end
end

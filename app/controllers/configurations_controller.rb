class ConfigurationsController < ApplicationController
  allow_unauthenticated_access

  def ios_v1
    render json: {
      settings: {},
      rules: [
        patterns: [
          "/session/new",
          "/users/new"
        ],
        properties: {
          context: "modal"
        }
      ]
    }
  end
end

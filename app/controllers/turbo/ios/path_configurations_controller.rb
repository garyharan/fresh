module Turbo
  module Ios
    class PathConfigurationsController < ApplicationController
      def show
        render json: {
          settings: {
            tabs: [
              {
                title: "Recommended",
                path: root_path,
                ios_system_image_name: "magnifyingglass.circle.fill"
              },
              {
                "title": "Chat",
                "path": "/rooms",
                "ios_system_image_name": "bubble.left.fill"
              },
              {
                "title": "Settings",
                "path": "/settings",
                "ios_system_image_name": "gearshape"
              }
            ]
          },
          rules: [
            {
              patterns: [
                "/new$",
                "/edit$"
              ],
              properties: {
                presentation: "modal"
              }
            },
            {
              patterns: [
                "/users/sign_in"
              ],
              properties: {
                flow: "authentication"
              }
            }
          ]
        }
      end
    end
  end
end

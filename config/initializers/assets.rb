# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = "1.0"

# Add additional assets to the asset load path.
# Rails.application.config.assets.paths << Emoji.images_path


# From: https://stackoverflow.com/questions/45237486/the-asset-application-js-is-not-present-in-the-asset-pipeline
Rails.application.config.assets.precompile += %w(application.js)

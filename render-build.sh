#!/usr/bin/env bash

bundle install
#bundle binstubs bundler --force

bundle exec rails tailwindcss:clobber
bundle exec rails tailwindcss:build
yarn build
yarn build:css
bundle exec rake assets:precompile
bundle exec rake assets:clean

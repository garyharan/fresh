#!/usr/bin/env bash

echo "Installing npm"
npm install

echo "Installing bundler"
bundle install

echo "yarn build"
yarn build

echo "Assets commands"
bundle exec rails tailwindcss:clobber
bundle exec rails tailwindcss:build
bundle exec rake assets:precompile
bundle exec rake assets:clean

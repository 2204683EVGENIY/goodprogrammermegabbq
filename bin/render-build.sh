#!/usr/bin/env bash
# exit on error
set -o errexit

bundle install &&
yarn install &&
yarn build &&
yarn build:css &&
bundle exec rails db:migrate &&
bundle exec rails assets:precompile

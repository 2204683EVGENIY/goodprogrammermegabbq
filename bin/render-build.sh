#!/usr/bin/env bash
# exit on error
set -o errexit

bundle install
yarn install
yarn build
yarn build:css
bundle exec rake db:migrate
bundle exec rake assets:precompile

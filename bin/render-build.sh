#!/usr/bin/env bash
# exit on error
set -o errexit

bundle install
yarn build

./bin/rails db:prepare

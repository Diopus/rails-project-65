#!/usr/bin/env bash
# exit on error
set -o errexit

./bin/rails tmp:clear

bundle install
yarn build

./bin/rails assets:precompile
./bin/rails assets:clean

./bin/rails db:prepare

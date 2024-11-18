setup:
	bin/setup
	yarn run build
	yarn run build:css

test:
	bin/rails test:system test

lint:
	bundle exec rubocop
	bundle exec slim-lint app/views/

check: lint test

ci-setup:
	cp -n .env.example .env || true
	yarn install
	bundle install --without production development
	# RAILS_ENV=test bin/rails db:prepare

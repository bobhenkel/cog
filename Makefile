.DEFAULT_GOAL := run
DOCKER_IMAGE      ?= operable/cog:0.5-dev

deps:
	mix deps.get

setup: deps
	mix ecto.setup

# Note: 'run' does not reset the database, in case you have data
# you're actively using. If this is your first time, run `make
# reset-db` before executing this recipe.
run:
	iex -S mix phoenix.server

reset-db: deps
	mix ecto.reset --no-start

test-rollbacks: export MIX_ENV = test
test-rollbacks: reset-db
	mix do ecto.rollback --all, ecto.drop

test: export MIX_ENV = test
test: reset-db
	mix test $(TEST)

test-all: export MIX_ENV = test
test-all: unit-tests integration-tests

unit-tests: export MIX_ENV = test
unit-tests: reset-db
	mix test --exclude=integration

integration-tests: export MIX_ENV = test
integration-tests: reset-db
	mix test --only=integration

test-watch: export MIX_ENV = test
test-watch: reset-db
	mix test.watch $(TEST)

docker:
	docker build --build-arg MIX_ENV=prod -t $(DOCKER_IMAGE) .

.PHONY: test docker unit-tests integration-tests deps

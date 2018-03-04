CONTAINER_COMMAND = start stop down build
DOCKER_COMPOSE_COMMAND = docker-compose -p myapp
DOCKER_COMMAND = docker
APP_REPOSITORY = git@github.com:RailsApps/learn-rails.git
SRC_DIR = $(PWD)/myapp
APP_BRANCH = master

.PHONY: init
init: clone/myapp build up
	$(MAKE) run COMMAND="/root/scripts/create_db.sh"

.PHONY: up
up: docker/up

.PHONY: restart
restart: down up

.PHONY: ps
ps:
	$(DOCKER_COMPOSE_COMMAND) ps

.PHONY: $(CONTAINER_COMMAND)
$(CONTAINER_COMMAND):
	$(DOCKER_COMPOSE_COMMAND) $@

.PHONY: docker/up
docker/up:
	$(DOCKER_COMPOSE_COMMAND) up -d

.PHONY: logs
logs:
	$(DOCKER_COMPOSE_COMMAND) logs -f app

.PHONY: db/logs
db/logs:
	$(DOCKER_COMPOSE_COMMAND) logs -f mysql

.PHONY: run
run: COMMAND = pwd
run:
	$(DOCKER_COMPOSE_COMMAND) exec spring bash -l -c "$(COMMAND)"

.PHONY: console
console:
	$(MAKE) run COMMAND="/bin/bash"

.PHONY: myapp/console
myapp/console:
	$(DOCKER_COMPOSE_COMMAND) exec app bash

.PHONY: rails/console
rails/console:
	$(MAKE) run COMMAND="bundle exec rails console"

.PHONY: migrate
migrate:
	$(MAKE) run COMMAND="bundle exec rake db:migrate"

# アプリのリポジトリをクローン
.PHONY: clone/myapp
clone/myapp:
	-git clone -b $(APP_BRANCH) $(APP_REPOSITORY) $(SRC_DIR)

.PHONY: db/console
db/console:
	$(MAKE) run COMMAND="bundle exec rails db -p"

.PHONY: bundle
bundle:
	$(MAKE) run COMMAND="bundle install"

.PHONY: test
test:
	$(MAKE) run COMMAND="bin/rspec"

.PHONY: app/restart
app/restart:
	$(MAKE) run COMMAND="bundle exec rails restart"

.PHONY: db/init
db/init:
	$(MAKE) run COMMAND="bundle exec rails db:drop db:create db:migrate"

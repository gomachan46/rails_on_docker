CONTAINER_COMMAND = start stop down build
DOCKER_COMPOSE_COMMAND = docker-compose -p myapp
DOCKER_COMMAND = docker
APP_BRANCH = master
APP_REPOSITORY = git@example.com:hoge/fuga
SRC_DIR = $(PWD)/myapp

# 一から作り直す
.PHONY: init
init:
	$(MAKE) _clean
	$(MAKE) _install
	$(MAKE) up
	$(MAKE) _bundler_waiter
	$(MAKE) db/init

# bundlerやmigrateなどの更新反映
.PHONY: up
up:
	$(DOCKER_COMPOSE_COMMAND) up -d --build
	$(MAKE) _bundle
	$(MAKE) _migrate


# 開発時に使うと良いかも系

.PHONY: logs/app
logs/app:
	$(DOCKER_COMPOSE_COMMAND) logs -f app

.PHONY: logs/db
logs/db:
	$(DOCKER_COMPOSE_COMMAND) logs -f mysql

.PHONY: console
console:
	$(MAKE) run COMMAND="/bin/bash"

.PHONY: myapp/console
myapp/console:
	$(DOCKER_COMPOSE_COMMAND) exec app bash

.PHONY: rails/console
rails/console:
	$(MAKE) run COMMAND="bundle exec rails console"

.PHONY: db/console
db/console:
	$(MAKE) run COMMAND="bundle exec rails db -p"

.PHONY: test
test:
	$(MAKE) run COMMAND="bin/rspec"

# railsサーバ再起動
.PHONY: app/restart
app/restart:
	$(MAKE) run COMMAND="bundle exec rails restart"

# 任意のコマンドを実行
.PHONY: run
run: COMMAND = pwd
run:
	$(DOCKER_COMPOSE_COMMAND) exec spring bash -l -c "$(COMMAND)"

# DBを一から作り直す
.PHONY: db/init
db/init:
	$(MAKE) run COMMAND="bundle exec rails db:drop db:create db:migrate"

# 立ち上がっているコンテナを確認
.PHONY: ps
ps:
	$(DOCKER_COMPOSE_COMMAND) ps


# 一般ユーザは実行しない系

.PHONY: _clean
_clean:
	rm -rf $(SRC_DIR)

.PHONY: _install
_install:
	-git clone -b $(APP_BRANCH) $(APP_REPOSITORY) $(SRC_DIR)

.PHONY: _bundler_waiter
_bundler_waiter:
	$(MAKE) run COMMAND="/root/scripts/bundler_waiter.sh"

.PHONY: _bundle
_bundle:
	$(MAKE) run COMMAND="bundle install"

.PHONY: _migrate
_migrate:
	$(MAKE) run COMMAND="bundle exec rake db:migrate"

.PHONY: $(CONTAINER_COMMAND)
$(CONTAINER_COMMAND):
	$(DOCKER_COMPOSE_COMMAND) $@

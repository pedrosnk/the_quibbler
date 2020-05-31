
DB_NAME=the_quibbler_db

dev_db:
	docker start $(DB_NAME) || docker run -p 5432:5432 --name $(DB_NAME) -d postgres:latest

run:
	iex -S mix phx.server

stop_db:
	docker stop $(DB_NAME)

setup: dev_db
	mix deps.get && \
	mix ecto.setup && \
	cd ./assets && yarn install

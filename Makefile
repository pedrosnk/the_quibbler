
DB_NAME=scroll_db

run:
	iex -S mix phx.server

start_db:
	docker start $(DB_NAME) || docker run -p 5432:5432 --name $(DB_NAME) -d postgres:latest

stop_db:
	docker stop $(DB_NAME)

setup: start_db
	mix deps.get && \
	mix ecto.setup && \
	cd ./assets && yarn install

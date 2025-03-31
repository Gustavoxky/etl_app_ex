FROM elixir:1.15-alpine

RUN apk add --no-cache build-base git postgresql-client

WORKDIR /app
COPY . .

WORKDIR /app/etl_web

RUN mix local.hex --force && \
    mix local.rebar --force && \
    mix deps.get && \
    mix compile

EXPOSE 4000
CMD ["mix", "phx.server"]

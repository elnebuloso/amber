FROM caddy:2-alpine

COPY docker/caddy/Caddyfile /etc/caddy/Caddyfile
COPY app /app

ENV APP_NAME=amber
ENV APP_TEXT_LEAD="This site is not online yet."

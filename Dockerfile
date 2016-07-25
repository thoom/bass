FROM ruby:alpine
MAINTAINER Z.d. Peacock <zdp@thoomtech.com>

COPY Gemfile /build/

RUN apk add --no-cache --update --virtual .build-deps build-base libxml2-dev libxslt-dev \
    && apk add --no-cache --update libxml2 libxslt mysql-client \
    && cd /build && bundle install \
    && apk del .build-deps

WORKDIR /backup

ENTRYPOINT ["backup"]

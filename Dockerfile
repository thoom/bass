FROM ruby:alpine
MAINTAINER Z.d. Peacock <zdp@thoomtech.com>

WORKDIR /backup
COPY ["Gemfile", "Backup", "./"]

RUN apk add --no-cache --update --virtual .build-deps build-base libxml2-dev libxslt-dev \
    && apk add --no-cache --update libxml2 libxslt mysql-client \
    && bundle install \
    && apk del .build-deps

ENTRYPOINT ["backup"]

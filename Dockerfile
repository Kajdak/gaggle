FROM ruby:3.3.0-alpine
ENV BUNDLER_VERSION=2.4.22

RUN apk add --update --no-cache \
    bash \
    binutils-gold \
    build-base \
    curl \
    file \
    g++ \
    gcc \
    git \
    less \
    libstdc++ \
    libffi-dev \
    libc-dev \ 
    linux-headers \
    libxml2-dev \
    libxslt-dev \
    libgcrypt-dev \
    make \
    netcat-openbsd \
    nodejs \
    openssl \
    pkgconfig \
    postgresql-dev \
    python \
    tzdata \
    yarn 
RUN gem install bundler

WORKDIR /app
COPY Gemfile Gemfile.lock /app/
RUN bundle config build.nokogiri --use-system-libraries
RUN bundle install

COPY . /app

CMD ["rails", "server", "-b", "0.0.0.0"]
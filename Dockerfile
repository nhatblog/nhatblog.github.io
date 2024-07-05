ARG RUBY_VERSION

FROM ruby:$RUBY_VERSION

# Configure bundler
ENV LANG=C.UTF-8 \
  BUNDLE_JOBS=4 \
  BUNDLE_RETRY=3 \
  TZ=Asia/Ho_Chi_Minh

ARG BUNDLER_VERSION
ARG APP_DIR

RUN apt-get update -qq \
  && apt-get install -yq --no-install-recommends \
     build-essential \
     curl \
  && apt-get clean \
  && rm -rf /var/cache/apt/archives/* \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
  && truncate -s 0 /var/log/*log

# Upgrade RubyGems and install required Bundler version
RUN echo 'gem: --no-document' > /usr/local/etc/gemrc
RUN gem update --system && \
    gem install bundler:$BUNDLER_VERSION

EXPOSE 4000
WORKDIR $APP_DIR

FROM ruby:alpine
RUN gem install scss_lint && mkdir /app
WORKDIR /app
ENTRYPOINT ["scss-lint"]

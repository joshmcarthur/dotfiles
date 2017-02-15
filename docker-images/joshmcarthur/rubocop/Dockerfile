FROM ruby:alpine
RUN gem install rubocop -v0.44.1 && mkdir /app
WORKDIR /app
ENTRYPOINT rubocop

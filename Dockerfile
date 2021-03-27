FROM ruby:2.5.8

RUN apt-get update -qq \
  && apt-get install -y nodejs postgresql-client \
  && apt-get -q clean \
  && rm -rf /var/lib/apt/lists

WORKDIR /usr/src/app
COPY Gemfile* ./
RUN bundle install
COPY . .

CMD bundle exec unicorn -c ./config/unicorn.rb && \
    bundle exec puma

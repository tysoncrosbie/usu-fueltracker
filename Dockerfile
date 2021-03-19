FROM ruby:2.2

RUN apt-get update -qq \
  && apt-get install -y nodejs postgresql-client \
  && apt-get -q clean \
  && rm -rf /var/lib/apt/lists

WORKDIR /usr/src/app
COPY Gemfile* ./
RUN gem install bundler -v 1.17.3 \
  && gem update --system 2.7.11 \
  && bundle _1.17.3_ install
COPY . .

CMD bundle exec unicorn -c ./config/unicorn.rb
CMD bundle exec puma

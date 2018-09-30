FROM pawurb/ruby-jemalloc-node-yarn:latest

RUN apt-get update && apt-get install -y tzdata && apt-get clean

ENV TZ America/New_York

COPY Gemfile* /tmp/
WORKDIR /tmp
RUN bundle install --jobs 5 --retry 5 --without development test

RUN mkdir /app
WORKDIR /app
COPY . /app
ENV RAILS_ENV production
ENV RACK_ENV production
CMD ["bin/run-dev.sh"]

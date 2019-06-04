FROM starefossen/ruby-node:2-10

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y tzdata git && apt-get clean

RUN mkdir /app
COPY Gemfile* /app/
COPY package.json /app/
COPY yarn.lock /app/
WORKDIR /app
RUN bundle install --frozen --jobs 5 --retry 5 --without development test
RUN yarn install --frozen-lockfile

COPY . /app

ENV RAILS_ENV production
ENV RACK_ENV production
RUN bundle exec rake assets:precompile

CMD ["bin/run-dev.sh"]

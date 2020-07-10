FROM ruby:latest as base
RUN apt-get update -qq &&\
        apt-get install -y  --no-install-recommends nodejs postgresql-client build-essential apt-transport-https ca-certificates &&\
        curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - &&\
        echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list &&\
        apt-get update -qq &&\
        apt-get install -y --no-install-recommends yarn &&\
        rm -rf /var/lib/apt/lists/*

FROM base as dev
WORKDIR /myapp
COPY Gemfile* /myapp/
COPY . /myapp
RUN bundle install
RUN bundle exec rake webpacker:install
RUN rails cequel:migrate

FROM dev as stage
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000
# Start the main process.
#CMD ["rails", "new", "blog", "---skip-active-record", "--skip-active-storage", "-T", "--skip-bundle"]
#CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
#CMD ["rails", "-s"]
CMD ["rails", "server", "-b", "0.0.0.0"]

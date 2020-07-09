FROM ruby:latest
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
RUN apt-get update && apt-get install -y \
  build-essential \
  nodejs  
RUN apt-get install -y apt-transport-https ca-certificates
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update && apt-get install -y yarn
RUN mkdir /myapp
WORKDIR /myapp
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock
RUN bundle install
COPY . /myapp
# Add a script to be executed every time the container starts.
RUN bundle exec rake webpacker:install
#RUN rails cequel:keyspace:create
RUN rails cequel:migrate
COPY entrypoint.sh /usr/bin/

RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000
# Start the main process.
#CMD ["rails", "new", "blog", "---skip-active-record", "--skip-active-storage", "-T", "--skip-bundle"]

#CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]

#CMD ["rails", "-s"]

CMD ["rails", "server", "-b", "0.0.0.0"]

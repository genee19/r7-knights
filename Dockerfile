FROM ruby:2.7.6-slim

ENV DEB_PACKAGES "\
  build-essential\
  libsqlite3-dev\
  libsqlite3-0\
  sqlite3\
"

RUN apt-get update && apt-get install -y --no-install-recommends $DEB_PACKAGES

WORKDIR /home/rails-app

# Local bin in PATH
RUN echo 'export PATH="/home/rails-app/bin:$PATH"' >> /root/.bashrc

# Bundle gems
RUN gem install bundler:2.3.13
COPY Gemfile* /home/rails-app/
RUN bundle install

COPY . /home/rails-app/

EXPOSE 3000
CMD ["bundle", "exec", "rails", "s"]

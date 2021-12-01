FROM ruby:2.6

RUN echo "deb http://mirrors.cloud.tencent.com/debian/ buster main non-free contrib"  > /etc/apt/sources.list && \
    echo "deb http://mirrors.cloud.tencent.com/debian-security buster/updates main" >> /etc/apt/sources.list && \
    echo "deb http://mirrors.cloud.tencent.com/debian/ buster-updates main non-free contrib" >> /etc/apt/sources.list && \
    echo "deb http://mirrors.cloud.tencent.com/debian/ buster-backports main non-free contrib" >> /etc/apt/sources.list && \
    echo "deb-src http://mirrors.cloud.tencent.com/debian-security buster/updates main" >> /etc/apt/sources.list && \
    echo "deb-src http://mirrors.cloud.tencent.com/debian/ buster main non-free contrib" >> /etc/apt/sources.list && \
    echo "deb-src http://mirrors.cloud.tencent.com/debian/ buster-updates main non-free contrib" >> /etc/apt/sources.list && \
    echo "deb-src http://mirrors.cloud.tencent.com/debian/ buster-backports main non-free contrib" >> /etc/apt/sources.list

# Install NodeJS
RUN apt-get update
RUN apt-get install -y apt-transport-https
RUN curl --silent --show-error --location https://deb.nodesource.com/gpgkey/nodesource.gpg.key | apt-key add -
RUN echo "deb https://deb.nodesource.com/node_6.x/ stretch main" > /etc/apt/sources.list.d/nodesource.list
RUN apt-get update
RUN apt-get install -y nodejs

# Install Yarn
RUN curl --silent --show-error --location https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" > /etc/apt/sources.list.d/yarn.list
RUN apt-get update
RUN apt-get install -y yarn

RUN bundle config mirror.https://rubygems.org https://gems.ruby-china.com
RUN mkdir /myapp
WORKDIR /myapp
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock
RUN gem install bundler
RUN bundle install
COPY . /myapp
RUN yarn install --check-files

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]
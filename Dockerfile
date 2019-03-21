FROM python:3.6-slim
MAINTAINER devcows <info@devcows.com>

# Install packages
RUN apt-get update
RUN apt-get install -qy curl build-essential libpq-dev git default-libmysqlclient-dev mysql-client

# Install Node
RUN curl -sL https://deb.nodesource.com/setup_6.x | bash -
RUN apt-get install -qy nodejs ruby
RUN gem install dpl -v 1.10.7

# ENV variables
ENV APP_HOME /usr/src/app
ENV DJANGO_CONFIGURATION Prod

# Prepare folders
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

# Install dependencies
COPY requirements $APP_HOME/requirements
COPY requirements.txt $APP_HOME/requirements.txt
RUN pip install -r requirements.txt

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

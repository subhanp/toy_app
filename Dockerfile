FROM phusion/passenger-ruby23:latest
MAINTAINER subhankhan "subhankhan3535@gmail.com"
# Set correct environment variables.
ENV HOME /root
ENV RAILS_ENV production
# Use baseimage-docker's init process.
CMD ["/sbin/my_init"]
# Start Nginx and Passenger
EXPOSE 80
RUN rm -f /etc/service/nginx/down
# Configure Nginx
RUN rm /etc/nginx/sites-enabled/default
ADD toy_app.conf /etc/nginx/sites-enabled/toy_app.conf
#ADD docker/postgres-env.conf /etc/nginx/main.d/postgres-env.conf
# Install the app
ADD . /home/ubuntu/toy_app
WORKDIR /home/ubuntu/toy_app

RUN bundle install --deployment
#RUN RAILS_ENV=production rake assets:precompile
# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

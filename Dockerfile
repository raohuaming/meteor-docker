FROM node:0.12

# Install Meteor
RUN curl https://install.meteor.com/ |sh

# install some tools
RUN npm install -g forever
RUN npm install -g mup

# Install scripts
ADD run.sh /run.sh
RUN chmod +x /run.sh
ADD build.sh /build.sh
RUN chmod +x /build.sh

# cleaning
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN npm cache clear

VOLUME /node_modules_cache
VOLUME /meteor_build_cache
CMD ["/bin/bash", "/run.sh"]

# build
ONBUILD COPY . /src

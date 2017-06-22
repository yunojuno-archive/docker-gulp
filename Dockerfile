# #!/bin/sh -x
# Container that is used to compile frontend assets.
FROM node:6

LABEL maintainer "YunoJuno <code@yunojuno.com>"

# run first so we commit the image layer before getting
# in to the phantom zone
RUN npm install --global gulp-cli

ENV PHANTOMJS_VERSION=2.1.1

# hard install phantomjs as per instructions on the phantom site.
RUN mkdir /opt/phantomjs && \
    wget --directory-prefix /opt/phantomjs https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-$PHANTOMJS_VERSION-linux-x86_64.tar.bz2  && \
    tar -xaf /opt/phantomjs/phantomjs-$PHANTOMJS_VERSION-linux-x86_64.tar.bz2 --strip-components=1 --directory "/opt/phantomjs" && \
    ln -s /opt/phantomjs/bin/phantomjs /usr/local/bin/phantomjs && \
    rm /opt/phantomjs/phantomjs-$PHANTOMJS_VERSION-linux-x86_64.tar.bz2

VOLUME ["/frontend"]
WORKDIR "/frontend"

ENTRYPOINT ["gulp"]

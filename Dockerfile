FROM persapiens/chrome-maven-openjdk:58-3.5.0-8u131
MAINTAINER Marcos Alexandre de Melo Medeiros <marcosamm@gmail.com>

ENV PINPOINT_VERSION 1.7.0-SNAPSHOT
ENV PINPOINT_HOME /opt/pinpoint

# update and upgrade
RUN apt-get update -qqy && \
    apt-get upgrade -qqy --no-install-recommends

ADD https://github.com/marcosamm/pinpoint-bin-snapshots/blob/master/pinpoint-agent-$PINPOINT_VERSION.tar.gz /tmp
#ADD https://github.com/naver/pinpoint/releases/download/$PINPOINT_VERSION/pinpoint-agent-$PINPOINT_VERSION.tar.gz /tmp
RUN mkdir -p $PINPOINT_HOME \
    && tar -xzvf /tmp/pinpoint-agent-$PINPOINT_VERSION.tar.gz -C $PINPOINT_HOME \
    && rm /tmp/pinpoint-agent-$PINPOINT_VERSION.tar.gz \
    && cd $PINPOINT_HOME \
    && mv pinpoint-bootstrap-PINPOINT_VERSION.jar pinpoint-bootstrap.jar

# clean temporary files
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /var/cache/apt/*
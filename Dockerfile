FROM java:openjdk-8-jre-alpine
MAINTAINER Justin Plock <justin@plock.net>

LABEL name="zookeeper" version="3.4.8"

RUN apk add --no-cache wget bash \
    && mkdir /opt \
    && wget -q -O - http://apache.mirrors.pair.com/zookeeper/zookeeper-3.4.8/zookeeper-3.4.8.tar.gz | tar -xzf - -C /opt \
    && mv /opt/zookeeper-3.4.8 /opt/zookeeper \
    && cp /opt/zookeeper/conf/zoo_sample.cfg /opt/zookeeper/conf/zoo.cfg \
    && mkdir -p /tmp/zookeeper

EXPOSE 2181 2888 3888
ENV NODE_INFO="" MYID=""

ADD ./cluter.sh /opt/zookeeper/bin/
RUN sed '1d' /opt/zookeeper/bin/zkServer.sh >> /opt/zookeeper/bin/cluter.sh && chmod a+x /opt/zookeeper/bin/cluter.sh 

WORKDIR /opt/zookeeper

VOLUME ["/opt/zookeeper/conf", "/tmp/zookeeper"]

ENTRYPOINT ["/opt/zookeeper/bin/cluter.sh"]
CMD ["start-foreground"]

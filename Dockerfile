FROM centos:centos7
MAINTAINER Marcin Ryzycki marcin@m12.io, Przemyslaw Ozgo linux@ozgo.info

ENV ES_VERSION=1.7.2

RUN \
    rpm --rebuilddb && yum clean all && \
    yum install -y tar java-1.8.0-openjdk sudo && \
    yum clean all && \
    mkdir -p /usr/share/elasticsearch && \
    cd /usr/share/elasticsearch && \
    curl -O https://download.elastic.co/elasticsearch/elasticsearch/elasticsearch-$ES_VERSION.tar.gz && \
    tar zxvf elasticsearch-${ES_VERSION}.tar.gz -C /usr/share/elasticsearch --strip-components=1 && \
    rm -f elasticsearch-${ES_VERSION}.tar.gz && \
    useradd elasticsearch && \
    chown -R elasticsearch:elasticsearch /usr/share/elasticsearch && \
    echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

COPY container-files /opt/

ENV MARVEL_SUPPORT=false

EXPOSE 9200

ENTRYPOINT ["/opt/bootstrap.sh"]

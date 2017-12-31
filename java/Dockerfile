FROM ubuntu:16.04

RUN apt-get update && \
    apt-get install -y --no-install-recommends \ 
       ca-certificates \
       curl \
       git \
       libhyperic-sigar-java \
       maven \
       openjdk-8-jdk \
       python \
       software-properties-common \
       xvfb \
       && \
    rm -rf /var/lib/apt/lists/*

COPY pom.xml /usr/local/maven-cache/pom.xml
WORKDIR /usr/local/maven-cache
RUN mvn -Dmaven.repo.local=/usr/local/maven-cache/.m2/repository clean compile package
RUN rm -rf /usr/local/maven-cache/.m2/repository/uk/ac/cam/cl/dtg/teaching/pottery-container-java/*SNAPSHOT
RUN find /usr/local/maven-cache/.m2 -type f -exec chmod 666 \{\} \;
RUN find /usr/local/maven-cache/.m2 -type d -exec chmod 777 \{\} \;
WORKDIR /

RUN gpg --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4
RUN curl -o /usr/local/bin/gosu -SL "https://github.com/tianon/gosu/releases/download/1.4/gosu-$(dpkg --print-architecture)" \
    && curl -o /usr/local/bin/gosu.asc -SL "https://github.com/tianon/gosu/releases/download/1.4/gosu-$(dpkg --print-architecture).asc" \
    && gpg --verify /usr/local/bin/gosu.asc \
    && rm /usr/local/bin/gosu.asc \
    && chmod +x /usr/local/bin/gosu
    
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
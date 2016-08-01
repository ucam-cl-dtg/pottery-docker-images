FROM ubuntu:16.04
RUN apt-get update && \
    apt-get install -y software-properties-common && \
    rm -rf /var/lib/apt/lists/*

RUN add-apt-repository -y ppa:webupd8team/java && \
    apt-get update && \
    echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
    echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections && \
    apt-get install -y oracle-java8-installer libhyperic-sigar-java git maven xvfb sudo && \
    rm -rf /var/lib/apt/lists/*


COPY pom.xml /maven-temp/
WORKDIR /maven-temp
RUN mkdir /.m2
RUN mvn -Dmaven.repo.local=/.m2/repository clean compile package && rm -rf /maven-temp
RUN rm -rf /.m2/repository/uk/ac/cam/cl/dtg/teaching/programming-test-java/*SNAPSHOT
RUN find /.m2 -type f -exec chmod 666 \{\} \;
RUN find /.m2 -type d -exec chmod 777 \{\} \;
WORKDIR /

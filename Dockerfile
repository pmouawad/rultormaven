FROM yegor256/rultor
MAINTAINER Philippe Mouawad <p.mouawad@ubik-ingenierie.com>
LABEL Description="This is a Rultor.com image with java 8 and Maven 3.5.0"

RUN add-apt-repository ppa:openjdk-r/ppa -y 
RUN apt-get update -y && \
	apt-get install openjdk-8-jdk -y 

ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64 
ENV MAVEN_VERSION 3.5.0
ENV M2_HOME "/usr/local/apache-maven/apache-maven-${MAVEN_VERSION}"

RUN set -x && \
 rm -rf /usr/lib/jvm/java-7-openjdk-amd64/ && \
  update-alternatives --install /usr/bin/java java $JAVA_HOME/bin/java 10000 && \
  update-alternatives --install /usr/bin/javac javac $JAVA_HOME/bin/javac 10000 && \
  wget --quiet "http://mirror.dkd.de/apache/maven/maven-3/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz" && \
  mkdir -p /usr/local/apache-maven && \
  mv "apache-maven-${MAVEN_VERSION}-bin.tar.gz" /usr/local/apache-maven && \
  tar xzvf "/usr/local/apache-maven/apache-maven-${MAVEN_VERSION}-bin.tar.gz" -C /usr/local/apache-maven/ && \
  update-alternatives --install /usr/bin/mvn mvn "${M2_HOME}/bin/mvn" 1 && \
  update-alternatives --config mvn &&\
  mvn -v


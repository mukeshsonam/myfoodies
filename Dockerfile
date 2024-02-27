FROM ubuntu:22.04

ENV TOMCAT_HOME=/u01/middleware/apache-tomcat-9.0.86
ENV PATH=$PATH:${TOMCAT_HOME}/bin
RUN mkdir -p /u01/middleware
WORKDIR /u01/middleware

RUN apt update -y

RUN apt-get install openjdk-11-jdk -y 
#ADD https://download.java.net/openjdk/jdk11.0.0.1/ri/openjdk-11.0.0.1_linux-x64_bin.tar.gz .
#RUN tar -xvzf openjdk-11.0.0.1_linux-x64_bin.tar.gz 
#RUN rm openjdk-11.0.0.1_linux-x64_bin.tar.gz 
ADD https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.86/bin/apache-tomcat-9.0.86.tar.gz .
RUN tar -xvzf apache-tomcat-9.0.86.tar.gz
RUN rm apache-tomcat-9.0.86.tar.gz

COPY target/foodies.war ${TOMCAT_HOME}/webapps
COPY run.sh /tmp
RUN chmod u+x /tmp/run.sh
RUN chmod u+x ${TOMCAT_HOME}/bin/startup.sh

ENTRYPOINT ["/tmp/run.sh", "echo","your deployment good"] 

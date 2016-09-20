FROM maven:3.2-jdk-8

ENV ANT_VERSION 1.9.7
RUN wget -q http://apache.mirrors.tds.net//ant/binaries/apache-ant-${ANT_VERSION}-bin.tar.gz -O /opt/ant.tar.gz
RUN tar -zxf /opt/ant.tar.gz -C /opt
RUN rm /opt/ant.tar.gz
ENV ANT_HOME /opt/apache-ant-${ANT_VERSION}
ENV PATH ${PATH}:${ANT_HOME}/bin

WORKDIR /opt/app

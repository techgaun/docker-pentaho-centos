FROM techgaun/centos6.6:java1.7

MAINTAINER Samar Acharya samar@techgaun.com

RUN yum update -y && \
    yum install -y wget unzip tar && \
    yum clean all
ENV BISERVER_TAG 5.2.0.0-209
ENV PENTAHO_HOME /opt/pentaho
ENV PENTAHO_JAVA_HOME $JAVA_HOME

WORKDIR /opt/
RUN wget http://softlayer-sng.dl.sourceforge.net/project/pentaho/Business%20Intelligence%20Server/5.2/biserver-ce-${BISERVER_TAG}.zip -O biserver-ce-${BISERVER_TAG}.zip && \
    unzip -q biserver-ce-${BISERVER_TAG}.zip -d $PENTAHO_HOME && \
    rm -f biserver-ce-${BISERVER_TAG}.zip $PENTAHO_HOME/biserver-ce/promptuser.sh && \
    sed -i -e 's/\(exec ".*"\) start/\1 run/' /opt/pentaho/biserver-ce/tomcat/bin/startup.sh && \
    chmod +x $PENTAHO_HOME/biserver-ce/start-pentaho.sh

RUN yum install -y http://yum.postgresql.org/9.3/redhat/rhel-6-x86_64/pgdg-centos93-9.3-1.noarch.rpm && \
    yum install -y postgresql93

COPY config $PENTAHO_HOME/config
COPY scripts $PENTAHO_HOME/scripts
COPY scripts/run.sh /
EXPOSE 8080
CMD ["/run.sh"]

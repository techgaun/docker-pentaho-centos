FROM techgaun/centos6.6:java1.7

MAINTAINER Samar Acharya samar@techgaun.com

RUN yum update -y && \
    yum install -y wget unzip tar && \
    yum clean all
ENV KETTLE_TAG 5.2.0.0-209
ENV PENTAHO_HOME /opt/pentaho
ENV PENTAHO_JAVA_HOME $JAVA_HOME

WORKDIR /opt/
RUN wget http://softlayer-sng.dl.sourceforge.net/project/pentaho/Data%20Integration/5.2/pdi-ce-${KETTLE_TAG}.zip -O pdi-ce-${KETTLE_TAG}.zip && \
    unzip -q pdi-ce-${KETTLE_TAG}.zip -d $PENTAHO_HOME && \
    rm -f pdi-ce-${KETTLE_TAG}.zip

COPY run.sh /opt/pentaho/data-integration/
COPY slave_dyn.xml /opt/pentaho/data-integration/

RUN chmod +x $PENTAHO_HOME/data-integration/run.sh

WORKDIR /opt/pentaho/data-integration

EXPOSE 8181
CMD ["./run.sh"]

FROM centos:7

COPY templates/centOS /etc/yum.repos.d/CentOS-Base.repo

RUN yum -y update && \
    yum -y install java-1.8.0-openjdk wget tar openssl

# Set environment variables
ENV CATALINA_HOME=/opt/tomcat

# Download and install Tomcat
RUN wget https://archive.apache.org/dist/tomcat/tomcat-8/v8.5.78/bin/apache-tomcat-8.5.78.tar.gz -O /tmp/tomcat.tar.gz && \
    mkdir -p ${CATALINA_HOME} && \
    tar xvf /tmp/tomcat.tar.gz --strip-components=1 -C ${CATALINA_HOME} && \
    rm /tmp/tomcat.tar.gz


WORKDIR /opt/tomcat/webapps

# Download and deploy the sample web app
COPY App/sample.war /opt/tomcat/webapps/sample.war

COPY ssl/cert.pem ${CATALINA_HOME}/conf/ssl/cert.pem
COPY ssl/key.pem ${CATALINA_HOME}/conf/ssl/key.pem


RUN openssl pkcs12 -export -in ${CATALINA_HOME}/conf/ssl/cert.pem -inkey ${CATALINA_HOME}/conf/ssl/key.pem -out ${CATALINA_HOME}/conf/ssl/keystore.p12 -name tomcat -password pass:changeit

# Convert PKCS#12 to JKS
RUN $JAVA_HOME/bin/keytool -importkeystore -srckeystore ${CATALINA_HOME}/conf/ssl/keystore.p12 -srcstoretype PKCS12 -srcstorepass changeit -destkeystore ${CATALINA_HOME}/conf/ssl/keystore.jks -deststoretype JKS -deststorepass changeit


COPY templates/server.xml ${CATALINA_HOME}/conf/server.xml

# Expose port 4041 for HTTPS
EXPOSE 4041

# Start Tomcat
CMD ["/opt/tomcat/bin/catalina.sh", "run"]
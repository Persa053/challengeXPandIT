FROM centos:7

COPY centOS /etc/yum.repos.d/CentOS-Base.repo

# Install Java and other required packages
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
COPY sample.war /opt/tomcat/webapps/sample.war

# Generate a self-signed SSL certificate
# RUN openssl req -newkey rsa:2048 -nodes -keyout ${CATALINA_HOME}/conf/ssl/keystore.jks -x509 -days 365 -out ${CATALINA_HOME}/conf/ssl/keystore.jks -subj "/C=US/ST=State/L=City/O=Company/OU=Department/CN=localhost" && \
#     keytool -importkeystore -deststorepass changeit -destkeypass changeit -destkeystore ${CATALINA_HOME}/conf/ssl/keystore.jks -srckeystore ${CATALINA_HOME}/conf/ssl/keystore.jks -srcstoretype JKS -srcstorepass changeit

# Configure Tomcat server for SSL
# RUN sed -i '/<\/Service>/i \
#   <Connector port="4041" protocol="org.apache.coyote.http11.Http11NioProtocol" \
#      maxThreads="150" SSLEnabled="true" scheme="https" secure="true" \
#      clientAuth="false" sslProtocol="TLS" \
#      keystoreFile="${CATALINA_HOME}/conf/ssl/keystore.jks" \
#      keystorePass="changeit" />' ${CATALINA_HOME}/conf/server.xml

# Expose port 4041 for HTTPS
EXPOSE 4041

# Start Tomcat
CMD ["/opt/tomcat/bin/catalina.sh", "run"]
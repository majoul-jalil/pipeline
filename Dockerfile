FROM tomcat:9.0.55
LABEL maintainer="pet"
ADD /target/petclinic.war /usr/local/tomcat/webapps/
EXPOSE 8080
CMD ["catalina.sh", "execute"]

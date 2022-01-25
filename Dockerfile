FROM tomcat:9.0
LABEL maintainer="pet"
ADD target/petclinic.war /usr/local/tomcat/webapps/ROOT.war
EXPOSE 8080
CMD ["catalina.sh", "run"]

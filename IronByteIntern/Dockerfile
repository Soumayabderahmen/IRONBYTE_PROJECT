#
# Build stage
#
FROM openjdk:17-jdk
COPY target/IronByteIntern.jar .
 # Expose le port 8060
EXPOSE 8060  
ENTRYPOINT ["java","-jar","IronByteIntern.jar"]
#CMD ["java","-jar","app.jar"]
#
# Build stage
#
FROM openjdk:17-jdk
COPY target/IronByteIntern.jar .
EXPOSE 9090
ENTRYPOINT ["java","-jar","IronByteIntern.jar"]
#CMD ["java","-jar","app.jar"]
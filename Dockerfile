FROM openjdk:8-jdk-alpine

#RUN mkdir -p /opt/digishot-test
WORKDIR /opt/digishot-test

ADD target/*.jar /opt/digishot-test/digishot-test.jar

ENV PORT 9898
EXPOSE $PORT

ENTRYPOINT ["java","-jar","-Xmx1024M","-Dserver.port=${PORT}","digishot-test.jar"]
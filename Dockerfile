# Docker Build Stage
#FROM maven:3-jdk-8-alpine AS build
FROM maven:3.6.0-jdk-8 AS build

WORKDIR /opt/digishot-test
COPY /c/Users/User/.m2 /root/.m2
#VOLUME /c/Users/User/.m2 /root/.m2

ADD ./pom.xml /opt/digishot-test/pom.xml
RUN mvn verify clean --fail-never

COPY ./ /opt/digishot-test
RUN mvn clean package -DskipTests

# Docker Deploy Stage
FROM openjdk:8-jdk-alpine

COPY --from=build /opt/digishot-test/target/*.jar digishot-test.jar

ENV PORT 9898
EXPOSE $PORT

ENTRYPOINT ["java","-jar","-Xmx1024M","-Dserver.port=${PORT}","digishot-test.jar"]
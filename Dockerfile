FROM openjdk:8-jdk-alpine

#RUN mkdir -p /opt/digishot-test
WORKDIR /opt/digishot-test

ADD target/*.jar /opt/digishot-test/digishot-test.jar

ENV PORT 9898
EXPOSE $PORT

ENTRYPOINT ["java","-jar","-Xmx1024M","-Dserver.port=${PORT}","digishot-test.jar"]

# COMMAND TO COPY THIS FILE INTO JENKINS CONTAINER
# docker cp /path/to/Dockerfile ${CONTAINER_ID}:/var/jenkins_home/dockerfiles/Dockerfile
# docker cp "C:\Users\User\Desktop\Postgrado\Modulo 18\Tesis (DevOps)\Jenkins-test\digishot-test\Dockerfile" 0b6dc9f38358eb46a13813011f2e31284aabf163981d1157616e65c4cc5c36e6:/var/jenkins_home/dockerfiles/Dockerfile
FROM gradle:jdk-alpine as build
WORKDIR /home/gradle/project
EXPOSE 8080
USER root
RUN apk update
ENV GRADLE_USER_HOME /home/gradle/project
COPY . /home/gradle/project
RUN ./gradlew build


FROM java:jre-alpine as app
WORKDIR /home/gradle/project
COPY --from=build /home/gradle/project/build/libs/project-0.0.1-SNAPSHOT.jar .
ENTRYPOINT java -jar project-0.0.1-SNAPSHOT.jar

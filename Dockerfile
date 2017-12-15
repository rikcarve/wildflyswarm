FROM openjdk:8-jre-slim
ARG APP_NAME
COPY $APP_NAME.jar $APP_NAME.jar
RUN java -jar $APP_NAME.jar

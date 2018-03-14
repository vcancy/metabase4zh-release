FROM ${DOCKER_REGISTRY}/jre8
WORKDIR /app
EXPOSE 3000
COPY ${PROJECT_NAME}.jar /app/
COPY start.sh /app/
COPY plugins/ /app/
ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN \
    chmod +x /app/start.sh
CMD ["/app/start.sh","${PROJECT_NAME}.jar"]
FROM alpine:3.14

ENV APP_HOME /node
RUN mkdir -p "$APP_HOME"
WORKDIR "$APP_HOME"

COPY ./tc-prebuilds/tc-*-linux-amd64 $APP_HOME/tc-service

EXPOSE 10002
CMD ["./tc-service"]
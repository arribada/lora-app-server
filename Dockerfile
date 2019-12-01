<<<<<<< HEAD
FROM --platform=$BUILDPLATFORM golang:1.12-alpine AS development
=======
FROM golang:1.13-alpine AS development
>>>>>>> master

ENV PROJECT_PATH=/chirpstack-application-server
ENV PATH=$PATH:$PROJECT_PATH/build
ENV CGO_ENABLED=0
ENV GO_EXTRA_BUILD_ARGS="-a -installsuffix cgo"

RUN apk add --no-cache ca-certificates make git bash alpine-sdk nodejs nodejs-npm

RUN mkdir -p $PROJECT_PATH
COPY . $PROJECT_PATH
WORKDIR $PROJECT_PATH

RUN make dev-requirements ui-requirements

# Install TARGETPLATFORM parser to translate its value to GOOS, GOARCH, and GOARM
COPY --from=tonistiigi/xx:golang / /
# Bring TARGETPLATFORM to the build scope
ARG TARGETPLATFORM

<<<<<<< HEAD
# RUN make

# FROM alpine:latest AS production

# WORKDIR /root/
# RUN apk --no-cache add ca-certificates
# COPY --from=development /lora-app-server/build/lora-app-server .
# ENTRYPOINT ["./lora-app-server"]
=======
WORKDIR /root/
RUN apk --no-cache add ca-certificates
COPY --from=development /chirpstack-application-server/build/chirpstack-application-server .
ENTRYPOINT ["./chirpstack-application-server"]
>>>>>>> master

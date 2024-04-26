FROM alpine:3.19.1
ARG SCANNER_VERSION=5.0.1.3006
RUN apk update && apk upgrade && \
    apk add --no-cache bash git openssh openjdk11 openjdk11-jre unzip wget
RUN wget https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-${SCANNER_VERSION}.zip && \
    unzip sonar-scanner-cli-${SCANNER_VERSION}.zip && \
    mv sonar-scanner-${SCANNER_VERSION} /opt/sonar-scanner && \
    rm -rf sonar-scanner-cli-${SCANNER_VERSION}.zip && \
    ln -s /opt/sonar-scanner/bin/sonar-scanner /bin/sonar-scaner

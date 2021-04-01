FROM alpine:3
RUN apk update && apk upgrade && \
    apk add --no-cache bash git openssh openjdk11 openjdk11-jre unzip wget
RUN wget https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-4.6.0.2311.zip && \
    unzip sonar-scanner-cli-4.6.0.2311.zip && \
    mv sonar-scanner-4.6.0.2311 /opt/sonar-scanner && \
    rm -rf sonar-scanner-cli-4.6.0.2311.zip && \
    ln -s /opt/sonar-scanner/bin/sonar-scanner /bin/sonar-scaner

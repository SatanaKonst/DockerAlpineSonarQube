#!/bin/bash

while getopts [s]:l:p: flag; do
  case "${flag}" in
  s) SEND='Y' ;;
  l) if [ ! -z "${OPTARG}" ]; then
    LOGIN=${OPTARG}
  fi ;;
  p) if [ ! -z "${OPTARG}" ]; then
    PASSWORD=${OPTARG}
  fi ;;

  esac
done

VERSION=$(grep "ARG SCANNER_VERSION" Dockerfile | cut -d '=' -f 2)

docker build -t konstatinkorobitsin/alpine-sonarqube:${VERSION} -t konstatinkorobitsin/alpine-sonarqube:latest .

if [ ! -z "$LOGIN" ] && [ ! -z "$PASSWORD" ]; then
  echo 'Login in hub'
  echo $PASSWORD | docker login -u ${LOGIN} --password-stdin
fi

if [[ "${SEND}" == 'Y' ]]; then
  echo 'Send image to Hub'
  docker push konstatinkorobitsin/alpine-sonarqube:latest && docker push konstatinkorobitsin/alpine-sonarqube:${VERSION}
fi

if [ ! -z "$LOGIN" ] && [ ! -z "$PASSWORD" ]; then
  echo 'Logout from hub'
  docker logout
fi

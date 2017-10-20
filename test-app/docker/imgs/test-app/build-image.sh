#!/usr/bin/env bash

cd "$(dirname "$0")"

mvn -f ../../../pom.xml clean compile assembly:single

cp ../../../target/test-app-1.0-SNAPSHOT-jar-with-dependencies.jar test-app.jar

docker build -t test-app:1.0 .

rm test-app.jar
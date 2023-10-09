FROM bellsoft/liberica-openjdk-alpine:17.0.8

# Install curl jq
RUN apk add curl jq

# workspace
WORKDIR /home/selenium-docker

# Add the required files
ADD target/docker-resources     ./
ADD runner.sh                   runner.sh

# Start the runner.sh
ENTRYPOINT  java -Dselenium.grid.enabled=true -Dselenium.grid.hubHost= 192.168.1.6 -cp 'libs/*' org.testng.TestNG test-suites/flight-reservation.xml

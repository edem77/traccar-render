FROM openjdk:17-jdk-slim

ENV TRACCAR_VERSION=5.12
ENV TRACCAR_HOME=/opt/traccar

RUN apt-get update && apt-get install -y wget unzip && rm -rf /var/lib/apt/lists/*

RUN mkdir -p $TRACCAR_HOME/conf
WORKDIR $TRACCAR_HOME

# Download Traccar
RUN wget https://github.com/traccar/traccar/releases/download/v${TRACCAR_VERSION}/traccar-other-${TRACCAR_VERSION}.zip \
    -O traccar.zip \
    && unzip traccar.zip -d $TRACCAR_HOME \
    && rm traccar.zip

# Copy config
COPY traccar.xml $TRACCAR_HOME/conf/traccar.xml

# Expose port
EXPOSE 8082

# Start server
CMD ["java", "-jar", "tracker-server.jar", "conf/traccar.xml"]


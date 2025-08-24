# Use OpenJDK base image
FROM openjdk:17-jdk-slim

# Set environment variables
ENV TRACCAR_VERSION=5.12 \
    TRACCAR_HOME=/opt/traccar

# Install required tools
RUN apt-get update && apt-get install -y wget unzip && rm -rf /var/lib/apt/lists/*

# Create Traccar directory
RUN mkdir -p $TRACCAR_HOME

# Download and extract Traccar
WORKDIR $TRACCAR_HOME
RUN wget https://github.com/traccar/traccar/releases/download/v${TRACCAR_VERSION}/traccar-other-${TRACCAR_VERSION}.zip \
    && unzip traccar-other-${TRACCAR_VERSION}.zip \
    && rm traccar-other-${TRACCAR_VERSION}.zip

# Copy custom configuration
COPY traccar.xml $TRACCAR_HOME/conf/traccar.xml

# Expose HTTP port
EXPOSE 8082

# Start Traccar
CMD ["java", "-jar", "tracker-server.jar", "conf/traccar.xml"]


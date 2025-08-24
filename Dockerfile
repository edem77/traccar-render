# Use OpenJDK base image
FROM openjdk:17-jdk-slim

# Environment variables
ENV TRACCAR_VERSION=5.12
ENV TRACCAR_HOME=/opt/traccar

# Install tools
RUN apt-get update && apt-get install -y wget unzip && rm -rf /var/lib/apt/lists/*

# Create directories
RUN mkdir -p $TRACCAR_HOME/conf

# Set working directory
WORKDIR $TRACCAR_HOME

# Download and extract Traccar
RUN wget https://github.com/traccar/traccar/releases/download/v${TRACCAR_VERSION}/traccar-other-${TRACCAR_VERSION}.zip \
    -O traccar.zip \
    && unzip traccar.zip -d $TRACCAR_HOME \
    && rm traccar.zip

# Copy custom configuration
COPY traccar.xml $TRACCAR_HOME/conf/traccar.xml

# Expose web port
EXPOSE 8082

# Run Traccar
CMD ["java", "-jar", "tracker-server.jar", "conf/traccar.xml"]


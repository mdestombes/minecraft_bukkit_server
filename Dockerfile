FROM openjdk:8-alpine

# Builder Maintainer
MAINTAINER mdestombes

# Fixed Environment
ARG BUKKIT_VERSION=1.13.2
ARG DYNMAP_VERSION=2645929

# Configuration variables
ENV SERVER_PORT=25565
ENV DYNMAP_PORT=8123
ENV MOTD="Welcome to Minecraft"

# Install dependencies
RUN apk update &&\
    apk add \
        tmux \
        wget \
        git \
        bash \
        python

# Download last Buildtool version
WORKDIR /minecraft/downloads
RUN wget -O /minecraft/downloads/BuildTools.jar https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar

# Bukkit version Builder
RUN java -jar BuildTools.jar --rev $BUKKIT_VERSION  2>&1 /dev/null

# Download plugins
WORKDIR /minecraft/downloads/plugins
RUN wget -O /minecraft/downloads/plugins/dynmap.jar https://dev.bukkit.org/projects/dynmap/files/${DYNMAP_VERSION}/download

# Copy Bukkit, Spigot and Plugins
WORKDIR /minecraft/bin
RUN cp /minecraft/downloads/craftbukkit-*.jar /minecraft/bin/craftbukkit.jar
RUN cp /minecraft/downloads/spigot-*.jar /minecraft/bin/spigot.jar

# Expose needed port
EXPOSE ${SERVER_PORT} ${DYNMAP_PORT}

# Copy runner
COPY run.sh /minecraft/bin/run.sh
COPY configure.py /minecraft/bin/configure.py
COPY dynmap_config.txt /minecraft/bin/dynmap_config.txt
RUN chmod +x /minecraft/bin/run.sh

# Change and share the data directory to Minecraft
WORKDIR /minecraft/data
RUN chmod -R 777 /minecraft/data
VOLUME  /minecraft/data

# Update game launch the game.
ENTRYPOINT ["/minecraft/bin/run.sh"]
CMD ["craftbukkit"]

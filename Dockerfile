FROM openjdk:8-alpine

# Builder Maintainer
MAINTAINER mdestombes

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

# Download last version
# From 'https://getbukkit.org'
WORKDIR /minecraft/downloads
RUN wget -O /minecraft/downloads/craftbukkit.jar https://cdn.getbukkit.org/craftbukkit/craftbukkit-1.15.2.jar
RUN wget -O /minecraft/downloads/spigot.jar https://cdn.getbukkit.org/spigot/spigot-1.15.2.jar

# Download Dynmap plugin file linked version
# From 'https://dev.bukkit.org/projects/dynmap/files'
WORKDIR /minecraft/downloads/plugins
RUN wget -O /minecraft/downloads/plugins/dynmap.jar https://media.forgecdn.net/files/2866/992/Dynmap-3.0-beta-10-spigot.jar

# Copy Bukkit, Spigot and Plugins
WORKDIR /minecraft/bin
RUN cp /minecraft/downloads/craftbukkit.jar /minecraft/bin/craftbukkit.jar
RUN cp /minecraft/downloads/spigot.jar /minecraft/bin/spigot.jar

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

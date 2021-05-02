FROM openjdk:8-alpine

# Builder Maintainer
MAINTAINER mdestombes

# Configuration variables
ENV SERVER_PORT=25565
ENV DYNMAP_PORT=8123
ENV MOTD="Welcome to Minecraft"
ENV DISCORD_BOT_TOKEN="BOTTOKEN"
ENV DISCORD_CHANNEL="000000000000000000"

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
RUN wget -O /minecraft/downloads/craftbukkit.jar https://cdn.getbukkit.org/craftbukkit/craftbukkit-1.16.5.jar
RUN wget -O /minecraft/downloads/spigot.jar https://cdn.getbukkit.org/spigot/spigot-1.16.5.jar

# Download Dynmap plugin file linked version
# From 'https://dev.bukkit.org/projects/dynmap/files'
WORKDIR /minecraft/downloads/plugins
RUN wget -O /minecraft/downloads/plugins/dynmap.jar https://media.forgecdn.net/files/3242/277/Dynmap-3.1-spigot.jar
RUN wget -O /minecraft/downloads/plugins/discorsrv.jar https://github.com/DiscordSRV/DiscordSRV/releases/download/v1.22.0/DiscordSRV-Build-1.22.0.jar

# Copy Bukkit, Spigot and Plugins
WORKDIR /minecraft/bin
RUN cp /minecraft/downloads/craftbukkit.jar /minecraft/bin/craftbukkit.jar
RUN cp /minecraft/downloads/spigot.jar /minecraft/bin/spigot.jar

# Expose needed port
EXPOSE ${SERVER_PORT} ${DYNMAP_PORT}

# Copy runner
COPY run.sh /minecraft/bin/run.sh
COPY configure.py /minecraft/bin/configure.py
COPY discordsrv_config.yml /minecraft/bin/discordsrv_config.yml
COPY discordsrv_messages.yml /minecraft/bin/discordsrv_messages.yml
COPY dynmap_config.txt /minecraft/bin/dynmap_config.txt
RUN chmod +x /minecraft/bin/run.sh

# Change and share the data directory to Minecraft
WORKDIR /minecraft/data
RUN chmod -R 777 /minecraft/data
VOLUME  /minecraft/data

# Update game launch the game.
ENTRYPOINT ["/minecraft/bin/run.sh"]
CMD ["craftbukkit"]

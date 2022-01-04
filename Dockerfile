FROM openjdk:17-alpine

# Builder Maintainer
MAINTAINER mdestombes

# Configuration variables
ENV AUTO_RESTART=true
ENV FORCE_CONFIG=false
ENV SERVER_PORT=25565
ENV DYNMAP_PORT=8123
ENV LOWER_MEM="1G"
ENV UPPER_MEM="1G"
ENV MOTD="Welcome to Minecraft"
ENV DEATH_AVAILABLE=3
ENV DISCORD_BOT_TOKEN="BOTTOKEN"
ENV DISCORD_CHANNEL="000000000000000000"

# Install dependencies
RUN apk update &&\
    apk add \
        tmux \
        wget \
        git \
        bash \
        nano \
        python3

# Download last version
# From 'https://getbukkit.org'
WORKDIR /minecraft/downloads
RUN wget -O /minecraft/downloads/craftbukkit.jar https://download.getbukkit.org/craftbukkit/craftbukkit-1.17.1.jar
RUN wget -O /minecraft/downloads/spigot.jar https://download.getbukkit.org/spigot/spigot-1.17.1.jar

# Copy plugins file linked version
# Manualy downloaded from https://www.spigotmc.org (WGET Blocked)
WORKDIR /minecraft/downloads/plugins
# https://www.spigotmc.org/resources/dynmap.274/ (v3.2 beta 3)
COPY plugins/dynmap.jar /minecraft/downloads/plugins/
# https://www.spigotmc.org/resources/discordsrv.18494/ (v1.24.0)
COPY plugins/discorsrv.jar /minecraft/downloads/plugins/
# https://www.spigotmc.org/resources/deathban.64283/ (v1.1.1)
COPY plugins/deathban.jar /minecraft/downloads/plugins/hardcore/

# Copy Bukkit, Spigot and Plugins
WORKDIR /minecraft/bin
RUN cp /minecraft/downloads/craftbukkit.jar /minecraft/bin/craftbukkit.jar
RUN cp /minecraft/downloads/spigot.jar /minecraft/bin/spigot.jar

# Expose needed port
EXPOSE ${SERVER_PORT} ${DYNMAP_PORT}

# Copy runner
COPY run.sh /minecraft/bin/run.sh
COPY configure.py /minecraft/bin/configure.py
COPY deathban_config.yml /minecraft/bin/deathban_config.yml
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
CMD ["spigot"]

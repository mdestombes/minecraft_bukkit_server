# Minecraft - Docker

__*Take care, `Last` version is often in dev. Use stable version with TAG*__

Docker build for managing a Minecraft Bukkit/Spigot server based on Alpine with Dynmap module include.

This image is borrowed from bbriggs/bukkit functionnalities.
Thanks for this good base of Dockerfile and existing structure.

This image uses [GetBukkit](https://getbukkit.org) to manage a Minecraft server.

---

## Features
 - Easy install
 - Easy port configuration
 - Easy access to Minecraft config file
 - `Docker stop` is a clean stop

---

## Variables

A full list of `server.properties` settings and their corresponding environment variables is included below, along with their defaults:

| Configuration Option          | Environment Variable          | Default                  |
| ------------------------------|-------------------------------|--------------------------|
| allow-flight                  | ALLOW_FLIGHT                  | `false`                  |
| allow-nether                  | ALLOW_NETHER                  | `true`                   |
| difficulty                    | DIFFICULTY                    | `1`                      |
| enable-command-block          | ENABLE_COMMAND_BLOCK          | `false`                  |
| enable-query                  | ENABLE_QUERY                  | `false`                  |
| enable-rcon                   | ENABLE_RCON                   | `false`                  |
| force-gamemode                | FORCE_GAMEMODE                | `false`                  |
| gamemode                      | GAMEMODE                      | `0`                      |
| generate-structures           | GENERATE_STRUCTURES           | `true`                   |
| generator-settings            | GENERATOR_SETTINGS            |                          |
| hardcore                      | HARDCORE                      | `false`                  |
| level-name                    | LEVEL_NAME                    | `world`                  |
| level-seed                    | LEVEL_SEED                    |                          |
| level-type                    | LEVEL_TYPE                    | `DEFAULT`                |
| max-build-height              | MAX_BUILD_HEIGHT              | `256`                    |
| max-players                   | MAX_PLAYERS                   | `20`                     |
| max-tick-time                 | MAX_TICK_TIME                 | `60000`                  |
| max-world-size                | MAX_WORLD_SIZE                | `29999984`               |
| motd                          | MOTD                          | `"Welcome to Minecraft"` |
| network-compression-threshold | NETWORK_COMPRESSION_THRESHOLD | `256`                    |
| online-mode                   | ONLINE_MODE                   | `true`                   |
| op-permission-level           | OP_PERMISSION_LEVEL           | `4`                      |
| player-idle-timeout           | PLAYER_IDLE_TIMEOUT           | `0`                      |
| prevent-proxy-connections     | PREVENT_PROXY_CONNECTIONS     | `false`                  |
| pvp                           | PVP                           | `true`                   |
| resource-pack                 | RESOURCE_PACK                 |                          |
| resource-pack-sha1            | RESOURCE_PACK_SHA1            |                          |
| server-ip                     | SERVER_IP                     |                          |
| server-port                   | SERVER_PORT                   | `25565`                  | 
| snooper-enabled               | SNOOPER_ENABLED               | `true`                   |
| spawn-animals                 | SPAWN_ANIMALS                 | `true`                   |
| spawn-monsters                | SPAWN_MONSTERS                | `true`                   |
| spawn-npcs                    | SPAWN_NPCS                    | `true`                   |
| view-distance                 | VIEW_DISTANCE                 | `10`                     |
| white-list                    | WHITE_LIST                    | `false`                  |

---

## Usage

### Basic run of the server

To start the server and accept the EULA in one fell swoop, just pass the `EULA=true` environment variable to Docker when running the container.

`docker run -it -p 25565:25565 -p 8123:8123 -e EULA=true --name minecraf_server mdestombes/minecraft_bukkit_server`

### Spigot included

Base of container minecraft is `bukkit`, but spigot server should be run too. To run the spigot server, supply it as an argument like so:
`docker run -it -p 25565:25565 -p 8123:8123 -e EULA=true --name minecraf_server mdestombes/minecraft_bukkit_server spigot`

### Configuration

You should be able to pass configuration options as environment variables like so:
`docker run -it -p 25565:25565 -p 8123:8123 -e EULA=true -e DIFFICULTY=2 -e MOTD="A specific welcome message" -e SPAWN_ANIMALS=false --name minecraf_server mdestombes/minecraft_bukkit_server`

This container will attempt to generate a `server.properties` file if one does not already exist. If you would like to use the configuration tool, be sure that you are not providing a configuration file or that you also set `FORCE_CONFIG=true` in the environment variables.

### Environment Files

Because of the potentially large number of environment variables that you could pass in, you might want to consider using an `environment variable file`. Example:
```
# env.list
ALLOW_NETHER=false
level-seed=123456789
EULA=true
```

`docker run -it -p 25565:25565 -p 8123:8123 --env-file env.list --name minecraf_server mdestombes/minecraft_bukkit_server`

### Saved run of the server

You can bring your own existing data + configuration and mount it to the `/data` directory when starting the container by using the `-v` option.

`docker run -it -v /my/path/to/minecraft:/minecraft/data/:rw -p 25565:25565 -p 8123:8123 -e EULA=true --name minecraf_server mdestombes/minecraft_bukkit_server`

---

## Recommended Usage

---

## Importants point in available volumes
+ __/minecraft/data__: Working data directory wich contains:
  + /minecraft/data/logs: Logs directory
  + /minecraft/data/plugin: Plugins directory
  + /minecraft/data/server.properties: Minecraft server properties

---

## Expose
+ Port: __SERVER_PORT__: Minecraft steam port (default: 25565)
+ Port: __DYNMAP_PORT__: Main server port (default: 8123)

---

## Known issues

---

## Changelog

| Tag      | Notes                   |
|----------|-------------------------|
| `1.0`    | Initialization          |
| `2.0`    | Minecraft 1.15.1        |

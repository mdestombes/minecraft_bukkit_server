# Minecraft - Docker

__*Take care, `Last` version is often in dev. Use stable version with TAG*__

Docker build for managing a Minecraft Bukkit/Spigot server based on Alpine with
 Dynmap, DiscordSRV and DeathBan (For Hardcore mode) module include.

The first version (v1.0) of image is borrowed from bbriggs/bukkit
 functionalities. Thanks for this good base of Dockerfile and existing
 structure.

This image uses [GetBukkit](https://getbukkit.org) to manage a Minecraft server.

---

## Features
 - Easy install
 - Easy port configuration
 - Easy access to Minecraft config file
 - Integrated Dynmap plugin with auto basic configuration
 - Integrated DiscordSRV plugin with auto basic configuration
 - Integrated DeathBan plugin with auto activation if Hardcore mode selected
 - `Docker stop` is a clean stop

---

## Input environment variables

### Main properties

A full list of `basic` settings and their corresponding environment
variables is included below, along with their defaults:

| Configuration Option          | Environment Variable          | Default                  |
| ------------------------------|-------------------------------|--------------------------|
| Auto restart after init       | AUTO_RESTART                  | `true`                   |
| Force configuration at start  | FORCE_CONFIG                  | `false`                  |

### Server properties

A full list of `server.properties` settings and their corresponding environment
variables is included below, along with their defaults:

| Configuration Option          | Environment Variable          | Default                  |
| ------------------------------|-------------------------------|--------------------------|
| allow-flight                  | ALLOW_FLIGHT                  | `false`                  |
| allow-nether                  | ALLOW_NETHER                  | `true`                   |
| difficulty                    | DIFFICULTY                    | `easy`                   |
| enable-command-block          | ENABLE_COMMAND_BLOCK          | `false`                  |
| enable-query                  | ENABLE_QUERY                  | `false`                  |
| enable-rcon                   | ENABLE_RCON                   | `false`                  |
| force-gamemode                | FORCE_GAMEMODE                | `false`                  |
| gamemode                      | GAMEMODE                      | `survival`               |
| generate-structures           | GENERATE_STRUCTURES           | `true`                   |
| generator-settings            | GENERATOR_SETTINGS            |                          |
| hardcore                      | -                             | `false`                  |
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

### Dynmap properties

A full list of `Dynmap` plugin base configuration, and their corresponding environment
variables is included below, along with their defaults:

| Configuration Option          | Environment Variable          | Default                  |
| ------------------------------|-------------------------------|--------------------------|
| Dynmap webpage port           | DYNMAP_PORT                   | `8123`                   |
| Title webpage                 | MOTD                          | `"Welcome to Minecraft"` |

### DiscordSRV properties

A full list of `DiscordSRV` plugin base configuration, and their corresponding environment
variables is included below, along with their defaults:

| Configuration Option          | Environment Variable          | Default                  |
| ------------------------------|-------------------------------|--------------------------|
| The Bot Discord Token         | DISCORD_BOT_TOKEN             | `BOTTOKEN`               |
| The discord linked channels   | DISCORD_CHANNEL               | `000000000000000000`     |

### DeathBan properties

The DeathBan plugin is activated only if at start you activate the Hardcore mode.

A full list of `DeathBan` plugin base configuration, and their corresponding environment
variables is included below, along with their defaults:

| Configuration Option          | Environment Variable          | Default                  |
| ------------------------------|-------------------------------|--------------------------|
| Max lives into the game       | DEATH_AVAILABLE               | `3`                      |

To get more information about his configuration, go to documentation available
 at [Spigot Plugin page](https://www.spigotmc.org/resources/deathban.64283/).

---

## Usage

### Basic run of the server

To start the server and accept the EULA in one fell swoop, just pass the
`EULA=true` environment variable to Docker when running the container.

`docker run -it -p 25565:25565 -p 8123:8123 -e EULA=true --name minecraf_server
mdestombes/minecraft_bukkit_server`

### Spigot included

Base of container minecraft is `bukkit`, but spigot server should be run too.
To run the spigot server, supply it as an argument like so:
`docker run -it -p 25565:25565 -p 8123:8123 -e EULA=true --name minecraf_server
mdestombes/minecraft_bukkit_server spigot`

### Configuration

You should be able to pass configuration options as environment variables like
so:
`docker run -it -p 25565:25565 -p 8123:8123 -e EULA=true -e DIFFICULTY=normal -e
MOTD="A specific welcome message" -e SPAWN_ANIMALS=false --name minecraf_server
mdestombes/minecraft_bukkit_server`

This container will attempt to generate a `server.properties` file if one does
not already exist. If you would like to use the configuration tool, be sure that
you are not providing a configuration file or that you also set
`FORCE_CONFIG=true` in the environment variables.

### Hardcore mode

Basically, Hardcore mode is not really operational on Bukkit/Spigot minecraft
 server. That's why the DeathBan plugin have been added. This plugin is
 activated only if at start you activate the Hardcore mode.

To activate Hardcore mode, use the __HARDCORE__ environment variable set to
`true` as:
`docker run -it -p 25565:25565 -p 8123:8123 -e EULA=true -e HARDCORE=true 
-e DIFFICULTY=normal -e MOTD="A specific welcome message" 
-e SPAWN_ANIMALS=false --name minecraf_server 
mdestombes/minecraft_bukkit_server`

### Environment Files

Because of the potentially large number of environment variables that you could
pass in, you might want to consider using an `environment variable file`.
Example:
```
# env.list
ALLOW_NETHER=false
level-seed=123456789
EULA=true
```

`docker run -it -p 25565:25565 -p 8123:8123 --env-file env.list --name
minecraf_server mdestombes/minecraft_bukkit_server`

### Saved run of the server

You can bring your own existing data + configuration and mount it to the `/data`
directory when starting the container by using the `-v` option.

`docker run -it -v /my/path/to/minecraft:/minecraft/data/:rw -p 25565:25565 -p
8123:8123 -e EULA=true --name minecraf_server
mdestombes/minecraft_bukkit_server`

---

## Discord Usage

This part is base on the French tutorial as:
[mTxServer](https://mtxserv.com/fr/article/12247/discordsrv_liez_discord_a_votre_serveur_minecraft)

Basically, DiscordSRV plugin is integrated to this container, but not configured.
So the plugin will automatically be deactivated. Don't worry...

To link your new Minecraft server, with a Discord Server, you need to:
- Have a Discord Server
- Create a Discord app/bot
- Add the link to DiscordSRV with input DiscordSRV environment variable
  properties
- Configure your Discord Server (With admin/powered role)

Don't be afraid, the procedure has followings...

### Create a Discord app/bot

- Step 1 => Go to site [Discord Developers](https://discord.com/developers/applications/).
- Step 2 => Create a __New application__
  Take care with the name, it is linked to the final name displayed on Discord.
  You can change it, but not too frequently!
- Step 3 => Create it
- Step 4 => Personalize it with `General Information` tab,
  like Name and Description.
- Step 5 => From `Bot` tab
  - Link a new bot with __Add bot__
    You need to confirm your creation with __Yes, do it!__
  - Change the __USERNAME__ field the final name.
    Take care with the name, it is linked to the final name displayed on Discord.
    You can change it, but not too frequently!
  - (Optional) You can change the image of your bot
    with yours.
  - Keep the token from the field __TOKEN__, it is used lower as [the_bot_token].
  - Activate option __SERVER MEMBERS INTENT__
    Otherwise the bot member sync feature probably won't work...
  - Saved the modification.
- Step 7 => From `General Information` tab, copy to clipboard the __CLIENT ID__
- Step 8 => Got to sit [Autorized](https://scarsz.me/authorize) and paste your
  __CLIENT ID__ from your clipboard.
  > The linked site have a script script in background who catch 
  > and verify the `CLIENT ID` and send it to discordapp.com.
  > I  orer to obtain the OAuth2 authentication for the bot.
  > You can manually add the `CLIENT ID` at the end of the following link:
  > https://discordapp.com/oauth2/authorize?scope=bot&client_id=
- Step 9 => Select you Discord target and __Autorize__
  The bot will appear as a new member on your Discord server.

### Discord server configuration

- Step 1 => Go to your Discord application.
- Step 2 => Open the users parameters (The gear at the bottom-left of Discord app).
  - Go to _Advanced application parameters_ tab
  - Activate __Developer Mode__
  - Saved the modification.
- Step 3 => With a right click on the target Discord channel, you can get
  the __CHANNEL_ID__, keep it, it is used lower as [the_discord_channel].
- Step 4 => Open the Discord __Server settings__ (The gear available into
  sub-menu from the Server name at the top-left).
  - Go to _Role_ tab.
    - Create a new role as `Bot`.
    - Add the authorization _Administrator_ to this new role.
      Keep it mind this role need to be the first of the role list.
      Otherwise the role sync feature probably won't work...
  - Go to _Member_ tab.
    - Add the `Bot` role to the new member (The Bot obviously)

### DiscordSRV plugin configuration

The DiscordSRV configuration is made with the input environment variable
mentioned upper. So... Your lonmy need is to put them at the initialization
of your container as:
`docker run -it -v /my/path/to/minecraft:/minecraft/data/:rw -p 25565:25565
-p 8123:8123 -e EULA=true -e DISCORD_BOT_TOKEN=[the_bot_token]
-e DISCORD_CHANNEL=[the_discord_channel] --name minecraf_server
mdestombes/minecraft_bukkit_server`

To fill [the_bot_token] use the __TOKEN__ of the bot created previously.

To fill [the_discord_channel] use the __CHANNEL_IDD__ of the previously selected
Discord channel.

---

## Recommended Usage

### Stopping container

To stop the server, more than 40 should be needed. 60 seconds set to internal
stop running process, to avoid lost data.

/!\ The default timeout of command `stop` from docker command is 10 second.

That's why I highly recommend to use the following parameter to use the `stop`
command :

`docker stop -t 70 minecraf_server`

---

## Important point in available volumes
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

| Tag      | Notes                                                         |
|----------|---------------------------------------------------------------|
| `1.0`    | -> Initialization                                             |
|          |                                                               |
| `2.0`    | -> Minecraft 1.15.1                                           |
|          |                                                               |
| `2.1`    | -> Minecraft 1.15.2                                           |
|          | -> Deactivate Spawn visualization on Dynmap                   |
|          |                                                               |
| `2.2`    | -> Minecraft 1.16.2                                           |
|          | -> Upgrade Dynmap configuration file                          |
|          | -> Up to 80 seconds during initializing reboot server         |
|          | -> Up to 30 seconds during stopping server                    |
|          |                                                               |
| `2.3`    | -> Minecraft 1.16.4                                           |
|          | -> Dynmap plugin 3.1-beta5                                    |
|          | -> Upgrade Dynmap configuration file                          |
|          | -> Upgrade server.properties generation (gamemode)            |
|          | -> Up to 90 seconds during initializing reboot server         |
|          | -> Up to 60 seconds during stopping server                    |
|          |                                                               |
| `2.4`    | -> Minecraft 1.16.5                                           |
|          | -> Dynmap plugin 3.1                                          |
|          | -> Upgrade Dynmap configuration file                          |
|          | -> Global upgrade server.properties generation                |
|          |                                                               |
| `2.5`    | -> Adding DiscordSRV plugin 1.22.0                            |
|          | -> Adding Environment input variables for DiscordSRV          |
|          | -> Adding DiscordSRV dedicated configuration files            |
|          | -> Update plugins initialization post first run               |
|          | -> Update README documentation for input available            |
|          | -> Adding documentation to link your both Servers:            |
|          |    - Discord                                                  |
|          |    - Minecraft                                                |
|          |                                                               |
| `2.6`    | -> Adding management for Auto-Restart at first initialization |
|          |                                                               |
| `2.7`    | -> Correction of default value for server.properties          |
|          | -> Correction of base config Dynmap file                      |
|          | -> Adding plugin DeathBan 1.1.1                               |
|          | -> Activation plugin DeathBan when Hardcore mode selected     |
|          | -> Sort server.properties in auto config                      |
|          |                                                               |
| `2.8`    | -> Change base from `openjdk:8-alpine` to `openjdk:15-alpine` |
|          | -> Change Python v2 to Python v3                              |
|          |                                                               |

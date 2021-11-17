#! /usr/bin/env python3

import os
import sys
import datetime
import argparse


minecraft_data = "/minecraft/data"


def send_command(input_command=None):
    if input_command is not None:
        final_command = "tmux send-keys -t minecraft '" + input_command + "' C-m"

        print (
            "Command [{0}] will be send...".format(final_command)
        )

        os.popen(
            "{0}".format(final_command)
        ).read()


def config_file():

    global minecraft_data

    properties = {
        "allow-flight": os.getenv(
            "ALLOW_FLIGHT", "false"),
        "allow-nether": os.getenv(
            "ALLOW_NETHER", "true"),
        "broadcast-console-to-ops": os.getenv(
            "BROADCAST_OPS", "true"),
        "broadcast-rcon-to-ops": os.getenv(
            "BROADCAST_OPS", "true"),
        "debug": os.getenv(
            "ENABLE_DEBUG", "false"),
        "difficulty": os.getenv(
            "DIFFICULTY", "easy"),
        "enable-command-block": os.getenv(
            "ENABLE_COMMAND_BLOCK", "false"),
        "enable-jmx-monitoring": os.getenv(
            "ENABLE_JMX", "false"),
        "enable-query": os.getenv(
            "ENABLE_QUERY", "false"),
        "enable-rcon": os.getenv(
            "ENABLE_RCON", "false"),
        "enable-status": os.getenv(
            "ENABLE_STATUS", "true"),
        "enforce-whitelist": os.getenv(
            "FORCE_WHITELIST", "false"),
        "entity-broadcast-range-percentage": os.getenv(
            "BROADCAST_ENTITY", 100),
        "force-gamemode": os.getenv(
            "FORCE_GAMEMODE", "false"),
        "function-permission-level": os.getenv(
            "FUNC_PERMISSION_LEVEL", 2),
        "gamemode": os.getenv(
            "GAMEMODE", "survival"),
        "generate-structures": os.getenv(
            "GENERATE_STRUCTURES", "true"),
        "generator-settings": os.getenv(
            "GENERATOR_SETTINGS"),
        "hardcore": "false",
        "level-name": os.getenv(
            "LEVEL_NAME", "world"),
        "level-seed": os.getenv(
            "LEVEL_SEED"),
        "level-type": os.getenv(
            "LEVEL_TYPE", "default"),
        "max-build-height": os.getenv(
            "MAX_BUILD_HEIGHT", 256),
        "max-players": os.getenv(
            "MAX_PLAYERS", 30),
        "max-tick-time": os.getenv(
            "MAX_TICK_TIME", 60000),
        "max-world-size": os.getenv(
            "MAX_WORLD_SIZE", 10000),
        "motd": os.getenv(
            "MOTD"),
        "network-compression-threshold": os.getenv(
            "NETWORK_COMPRESSION_THRESHOLD", 256),
        "online-mode": os.getenv(
            "ONLINE_MODE", "true"),
        "op-permission-level": os.getenv(
            "OP_PERMISSION_LEVEL", 4),
        "player-idle-timeout": os.getenv(
            "PLAYER_IDLE_TIMEOUT", 0),
        "prevent-proxy-connections": os.getenv(
            "PREVENT_PROXY_CONNECTIONS", "false"),
        "pvp": os.getenv(
            "PVP", "true"),
        "query.port": os.getenv(
            "SERVER_PORT", 25565),
        "rate-limit": os.getenv(
            "RATE_LIMIT", 0),
        "rcon.password": os.getenv(
            "RCON_PASSWORD"),
        "rcon.port": os.getenv(
            "RCON_PORT", 25575),
        "require-resource-pack": os.getenv(
            "REQUIRE_RESOURCE_PACK", "false"),
        "resource-pack": os.getenv(
            "RESOURCE_PACK"),
        "resource-pack-prompt": os.getenv(
            "RESOURCE_PACK_PROMPT"),
        "resource-pack-sha1": os.getenv(
            "RESOURCE_PACK_SHA1"),
        "server-ip": os.getenv(
            "SERVER_IP"),
        "server-port": os.getenv(
            "SERVER_PORT", 25565),
        "snooper-enabled": os.getenv(
            "SNOOPER_ENABLED", "true"),
        "spawn-animals": os.getenv(
            "SPAWN_ANIMALS", "true"),
        "spawn-monsters": os.getenv(
            "SPAWN_MONSTERS", "true"),
        "spawn-npcs": os.getenv(
            "SPAWN_NPCS", "true"),
        "spawn-protection": os.getenv(
            "SPAWN_PROTECTION", 30),
        "sync-chunk-writes": os.getenv(
            "SYNC_CHUNK", "true"),
        "text-filtering-config": os.getenv(
            "TEXT_FILTERING"),
        "use-native-transport": os.getenv(
            "NATIVE_TRANSP", "true"),
        "view-distance": os.getenv(
            "VIEW_DISTANCE", 10),
        "white-list": os.getenv(
            "WHITE_LIST", "false"),
    }

    with open(minecraft_data + "/server.properties", 'w') as f:
        now = datetime.datetime.now().isoformat()

        f.write("# Minecraft server properties\n")
        f.write("# Automatically generated at {}\n\n".format(now))

        for k, v in properties.items():
            if not v:
                f.write('{}=\n'.format(k))
            elif isinstance(v, (int)):
                f.write('{}={}\n'.format(k, v))
            else:
                f.write('{}={}\n'.format(k, v))


if __name__ == "__main__":

    # Check arguments
    parser = argparse.ArgumentParser(description='Minecraft configuration tools.')

    parser.add_argument('-c', '--config',
                        help='creation of server.properties file',
                        action="store_true")
    parser.add_argument('-C', '--command',
                        help='sending command in server command admin')
    parser.add_argument("-v", "--verbose",
                        help='active logs',
                        action="store_true")

    if (
            parser.parse_args().config is False and
            parser.parse_args().command is None
    ):
        parser.print_help()
    else:

        if parser.parse_args().config:
            config_file()

        if parser.parse_args().command:
            send_command(parser.parse_args().command)

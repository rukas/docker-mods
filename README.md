# Home Assistant - Docker mod for code-server

This mod adds Home Assistant related add-ons to code-server, to be installed/updated during container start.

In code-server docker arguments, set an environment variable `DOCKER_MODS=linuxserver/mods:code-server-python3|stecky/code-server-home-assistant-mod`
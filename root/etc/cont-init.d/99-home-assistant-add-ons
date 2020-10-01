#!/usr/bin/with-contenv bash
# ==============================================================================
# Node-RED for Home Assistant Core
# Configures Node-RED before running
# ==============================================================================

# Ensure configuration files exist
FILE=/data/flows.json
if [ -f "$FILE" ]; then
    echo "$FILE exists."
else
    cp /etc/node-red/flows.json $FILE
fi

FILE=/data/settings.js
if [ -f "$FILE" ]; then
    echo "$FILE exists."
else
    cp /etc/node-red/settings.js $FILE
fi

# Create random flow id
id=$(node -e "console.log((1+Math.random()*4294967295).toString(16));")
sed -i "s/%%ID%%/${id}/" "/data/flows.json"

# Inject HA URL and access token
sed -i "s~%%URL%%~${HOMEASSISTANT_URL}~" "/data/flows.json"
sed -i "s/%%PASS%%/${HOMEASSISTANT_TOKEN}/" "/data/flows.json"

# Patch Node-RED Dashboard
cd /usr/src/root/node_modules/node-red-dashboard
patch -p1 < /etc/node-red/patches/node-red-dashboard-show-dashboard.patch

# Inject Node-RED port
sed -i "s/%%PORT%%/${TCP_PORT_1880:-1880}/" "/usr/src/root/node_modules/node-red-dashboard/nodes/ui_base.html"

# Ensures conflicting Node-RED packages are absent
cd /data
if [ -f "/data/package.json" ]; then
    npm uninstall \
        node-red-contrib-home-assistant \
        node-red-contrib-home-assistant-llat \
        node-red-contrib-home-assistant-ws
fi

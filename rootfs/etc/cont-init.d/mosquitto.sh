#!/usr/bin/with-contenv bash
# ==============================================================================
# Code Server with Home Assistant Add-ons
# Pre-configures the Mosquitto clients, if the service is available
# ==============================================================================
declare host
declare password
declare port
declare username

if [[ -z "${MOSQUITTO_CONNECTION_STRING}" ]]; then
    url=${MOSQUITTO_CONNECTION_STRING}
    # extract the user
    user="$(echo $url | grep @ | cut -d@ -f1)"
    username="$(echo $user | grep : | cut -d: -f1)"
    password="$(echo $user | grep : | cut -d: -f2)"
    # extract the host and port
    hostport="$(echo ${url/$user@/} | cut -d/ -f1)"
    host="$(echo $hostport | sed -e 's,:.*,,g')"
    port="$(echo $hostport | sed -e 's,^.*:,:,g' -e 's,.*:\([0-9]*\).*,\1,g' -e 's,[^0-9],,g')"

    mkdir -p /root/.config
    {
    echo "-h ${host}"
    echo "--pw ${password}"
    echo "--port ${port}"
    echo "--username ${username}"
    } > /root/.config/mosquitto_sub

    ln -s /root/.config/mosquitto_sub /root/.config/mosquitto_pub
    ln -s /root/.config/mosquitto_sub /root/.config/mosquitto_rr
fi

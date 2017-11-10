#!/bin/sh

echo "Starting knxsonos service."

ARGS=$@
echo "ARGS: $ARGS"

CONFIG_PATH=/etc/knxsonos

if [ ! -e "$CONFIG_PATH/knxsonos.config" ]; then
    echo "No config file found, using example file"
    cp /root/knxsonos.config $CONFIG_PATH/;
fi

chown knxsonos:knxsonos /etc/knxsonos/knxsonos.config

echo "Press <ctrl>-c to abort"
su -s /bin/sh -c "knxsonos $ARGS" knxsonos

# Workaround because knxd always forks to background
while [ true ] ; do
    sleep 5
done

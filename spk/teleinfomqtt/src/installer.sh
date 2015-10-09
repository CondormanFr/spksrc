#!/bin/sh

# Package
PACKAGE="TeleinfoMqtt"
DNAME="Telmeinfo MQTT"

# Others
SSS="/var/packages/${PACKAGE}/scripts/start-stop-status"
INSTALL_DIR="/usr/local/${PACKAGE}"
PATH="${INSTALL_DIR}/bin:${PATH}"

preinst ()
{
    exit 0
}

postinst ()
{
    exit 0
}

preuninst ()
{
    exit 0
}

postuninst ()
{
    exit 0
}

preupgrade ()
{
    exit 0
}
postupgrade ()
{
    exit 0
}

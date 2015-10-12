#!/bin/sh

# Package
PACKAGE="teleinfomqtt"
DNAME="Teleinfo MQTT"

# Others
#SSS="/var/packages/${PACKAGE}/scripts/start-stop-status"
INSTALL_DIR="/usr/local/${PACKAGE}"
PATH="${INSTALL_DIR}/bin:${PATH}"
SSS="/var/packages/${PACKAGE}/scripts/start-stop-status"

USER="teleinfomqtt"
GROUP="uucp"

CFG_FILE="${INSTALL_DIR}/var/TeleInfoMqtt.conf"

preinst ()
{
    exit 0
}

postinst ()
{
    # Link
    ln -s ${SYNOPKG_PKGDEST} ${INSTALL_DIR}

     # Install busybox stuff
    ${INSTALL_DIR}/bin/busybox --install ${INSTALL_DIR}/bin
 

    # Create user
    adduser -h ${INSTALL_DIR}/var -g "${DNAME} User" -G ${GROUP} -s /bin/sh -S -D ${USER}

    if [ "${SYNOPKG_PKG_STATUS}" == "INSTALL" ]; then
        # Edit the configuration according to the wizard
        sed -i -e "s|@Port@|${wizard_serial_port:=/dev/tty1}|g" ${CFG_FILE}
        sed -i -e "s|@Broker_Host@|${wizard_BrokerHost:=localhost}|g" ${CFG_FILE}
        sed -i -e "s|@Broker_Port@|${wizard_BrokerPort:=1883}|g" ${CFG_FILE}
        sed -i -e "s|@Topic@|${wizard_mqtttopic:=TeleInfo/Production}|g" ${CFG_FILE}
    fi
    exit 0
}

preuninst ()
{

    # Stop the package
    ${SSS} stop > /dev/null

    exit 0
}

postuninst ()
{
    # Remove link
    rm -f ${INSTALL_DIR}
    exit 0
}

preupgrade ()
{
    # Stop the package
    ${SSS} stop > /dev/null
    exit 0
}
postupgrade ()
{
    exit 0
}

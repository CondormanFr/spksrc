#!/bin/sh

# Package
PACKAGE="weewx"
DNAME="WeeWX"

# Others
INSTALL_DIR="/usr/local/${PACKAGE}"
SSS="/var/packages/${PACKAGE}/scripts/start-stop-status"
PYTHON_DIR="/usr/local/python"
PATH="${INSTALL_DIR}/bin:${INSTALL_DIR}/env/bin:${INSTALL_DIR}/lib:${PYTHON_DIR}/bin:${PATH}"
USER="weewx"
GROUP="users"
VIRTUALENV="${PYTHON_DIR}/bin/virtualenv"
CFG_FILE="${INSTALL_DIR}/share/weewx/setup.cfg"
TMP_DIR="${SYNOPKG_PKGDEST}/../../@tmp"

SERVICETOOL="/usr/syno/bin/servicetool"

syno_group_create ()
{
    # Add user to syno group (Does nothing when user already in the group)
    addgroup ${USER} ${GROUP}
}

syno_group_remove ()
{
    # Remove user from syno group
    delgroup ${USER} ${GROUP}

    # Check if syno group is empty
    if ! synogroup --get ${GROUP} | grep -q "0:"; then
        # Remove syno group
        synogroup --del ${GROUP} > /dev/null
    fi
}

preinst ()
{
    exit 0
}

postinst ()
{
    # Link
    ln -s ${SYNOPKG_PKGDEST} ${INSTALL_DIR}
    
    # Create a Python virtualenv
    ${VIRTUALENV} --system-site-packages ${INSTALL_DIR}/env > /dev/null

    # Install Markdown
    ${INSTALL_DIR}/env/bin/pip install markdown > /dev/null

    # Install the wheels
    ${INSTALL_DIR}/env/bin/pip install --no-deps --no-index -f ${INSTALL_DIR}/share/wheelhouse -r ${INSTALL_DIR}/share/wheelhouse/requirements.txt > /dev/null

    # Install PAHO-MQTT
    ${INSTALL_DIR}/env/bin/pip install paho-mqtt > /dev/null
    
    # Edit the configuration according to the wizard
    sed -i -e "s|@weewx_home_folder@|${wizard_weewx_home_folder:=/volume1/public/weewx}|g" ${CFG_FILE}
    sed -i -e "s|@weewx_home_folder@|${wizard_weewx_home_folder:=/volume1/public/weewx}|g" ${SSS}

    # Setup weewx
    cd ${INSTALL_DIR}/share/weewx 
    ${INSTALL_DIR}/env/bin/python ${INSTALL_DIR}/share/weewx/setup.py build > /dev/null
    
    ${INSTALL_DIR}/env/bin/python ${INSTALL_DIR}/share/weewx/setup.py install --no-prompt > /dev/null
    
    ${wizard_weewx_home_folder:=/volume1/public/weewx}/bin/wee_extension --install ${INSTALL_DIR}/extension/weewx-mqtt-0.9.tgz > /dev/null

    # Install busybox stuff
    ${INSTALL_DIR}/bin/busybox --install ${INSTALL_DIR}/bin

    # Create user
    adduser -h ${INSTALL_DIR}/var -g "${DNAME} User" -G ${GROUP} -s /bin/sh -S -D ${USER}

    if [ "${SYNOPKG_PKG_STATUS}" == "INSTALL" ]; then
        # Edit the configuration according to the wizard
        sed -i -e "s|@download_dir@|${wizard_download_dir:=/volume1/downloads}|g" ${CFG_FILE}
        # Set group and permissions on download dir for DSM5
        if [ `/bin/get_key_value /etc.defaults/VERSION buildnumber` -ge "4418" ]; then
            chgrp users ${wizard_download_dir:=/volume1/downloads}
            chmod g+rw ${wizard_download_dir:=/volume1/downloads}
        fi
    fi

    syno_group_create

    # Correct the files ownership
    chown -R ${USER}:root ${SYNOPKG_PKGDEST}
    chown -R ${USER}:root ${wizard_weewx_home_folder:=/volume1/public/weewx}

    # Add firewall config
    #${SERVICETOOL} --install-configure-file --package ${FWPORTS} >> /dev/null

    exit 0
}

preuninst ()
{
    # Stop the package
    ${SSS} stop > /dev/null

    # Remove the user (if not upgrading)
    if [ "${SYNOPKG_PKG_STATUS}" != "UPGRADE" ]; then
        syno_group_remove

        delgroup ${USER} ${GROUP}
        deluser ${USER}
    fi


    exit 0
}

postuninst ()
{
    # Remove link
    rm -f ${INSTALL_DIR}
    
    rm ${wizard_weewx_home_folder:=/volume1/public/weewx}/bin/weewxd.py

    exit 0
}

preupgrade ()
{
    # Stop the package
    ${SSS} stop > /dev/null

    # Save some stuff
    rm -fr ${TMP_DIR}/${PACKAGE}
    mkdir -p ${TMP_DIR}/${PACKAGE}
    mv ${INSTALL_DIR}/var ${TMP_DIR}/${PACKAGE}/

    exit 0
}

postupgrade ()
{
    # Restore some stuff
    rm -fr ${INSTALL_DIR}/var
    mv ${TMP_DIR}/${PACKAGE}/var ${INSTALL_DIR}/
    rm -fr ${TMP_DIR}/${PACKAGE}

    exit 0
}
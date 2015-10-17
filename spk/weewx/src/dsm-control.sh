#!/bin/sh

# Package
PACKAGE="weewx"
DNAME="weewx"

# Others
INSTALL_DIR="/usr/local/${PACKAGE}"
PYTHON_DIR="/usr/local/python"
PATH="${INSTALL_DIR}/bin:${INSTALL_DIR}/env/bin:${PYTHON_DIR}/bin:${PATH}"
USER="weewx"
PYTHON="${INSTALL_DIR}/env/bin/python"
#SABNZBD="${INSTALL_DIR}/share/weewx/SABnzbd.py"
WEEWXD="/volume1/public/weewx/system/bin/weewxd"
CFG_FILE="/volume1/public/weewx/system/weewx.conf"
LOG_FILE="${INSTALL_DIR}/var/logs/weewx.log"
PID_FILE="${INSTALL_DIR}/var/weewx.pid"
RUN_ARGS="--daemon {CFG_FILE}" 


start_daemon ()
{
    start-stop-daemon -S -c ${USER] -p ${PID_FILE} -x env PATH=${PATH} ${WEEWXD} -- ${RUN_ARGS} || return 2
}

stop_daemon ()
{
    start-stop-daemon -K -q -u ${USER} -p ${PID_FILE}
    wait_for_status 1 20 || start-stop-daemon -K -s 9 -q -p ${PID_FILE}
    rm -f ${PID_FILE}
    #kill `cat ${PID_FILE}`
    #wait_for_status 1 20
    #kill -9 `cat ${PID_FILE}`
    #rm -f ${PID_FILE}
}

daemon_status ()
{
    if [ -f ${PID_FILE} ] && kill -0 `cat ${PID_FILE}` > /dev/null 2>&1; then
        return
    fi
    rm -f ${PID_FILE}
    return 1
}

wait_for_status ()
{
    counter=$2
    while [ ${counter} -gt 0 ]; do
        daemon_status
        [ $? -eq $1 ] && return
        let counter=counter-1
        sleep 1
    done
    return 1
}


case $1 in
    start)
        if daemon_status; then
            echo ${DNAME} is already running
            exit 0
        else
            echo Starting ${DNAME} ...
            start_daemon
            exit $?
        fi
        ;;
    stop)
        if daemon_status; then
            echo Stopping ${DNAME} ...
            stop_daemon
            exit $?
        else
            echo ${DNAME} is not running
            exit 0
        fi
        ;;
    status)
        if daemon_status; then
            echo ${DNAME} is running
            exit 0
        else
            echo ${DNAME} is not running
            exit 1
        fi
        ;;
    log)
        echo ${LOG_FILE}
        exit 0
        ;;
    *)
        exit 1
        ;;
esac

#!/bin/sh

# Package
PACKAGE="teleinfotomqtt"
DNAME="teleinfo -> mqtt"

# Others
INSTALL_DIR="/usr/local/${PACKAGE}"
PATH="${INSTALL_DIR}/bin:${PATH}"
USER="teleinfo2mqtt"
CFG_FILE="${INSTALL_DIR}/conf/teleinfo2mqtt.conf"
TELEINFO2MQTT="${INSTALL_DIR}/bin/TeleInfod"
PID_FILE="${INSTALL_DIR}/var/TeleInfod.pid"
RUN_ARGS="-d -f${CFG_FILE}"
LOG_FILE="${INSTALL_DIR}/var/Teleinfo2Mqtt.log"



start_daemon ()
{
    stty 1200 cs7 evenp cstopb -igncr -inlcr -brkint -icrnl -opost -isig -icanon -iexten -F @Port@
    start-stop-daemon -S -m -c ${USER} -u ${USER} -b -p ${PID_FILE} -x ${TELEINFO2MQTT} -- ${RUN_ARGS}
    exit 0 

}

stop_daemon ()
{
    start-stop-daemon -K -q -u ${USER} -p ${PID_FILE}
    wait_for_status 1 20 || start-stop-daemon -K -s 9 -q -p ${PID_FILE}
    rm -f ${PID_FILE}
    exit 0
}

daemon_status ()
{
    start-stop-daemon -K -q -t -u ${USER} -p ${PID_FILE}
    [ $? -eq 0 ] || return 1
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
        exit 1
        ;;
    *)
        exit 1
        ;;
esac 

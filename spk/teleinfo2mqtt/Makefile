SPK_NAME = teleinfo2mqtt
SPK_VERS = 1.00
SPK_REV = 1
SPK_ICON = src/teleinfo2mqtt.png

DEPENDS = cross/busybox cross/$(SPK_NAME)

MAINTAINER = SynoCommunity
DESCRIPTION = This proram read TELEINFO signal from serial port and send data to a MQTT broker 
DESCRIPTION_FRE =Programme qui écoute le signal TELEINFO sur le port série et qui envoie les trames sur un broker MQTT.
RELOAD_UI = yes
DISPLAY_NAME = Teleinfo2MQTT
CHANGELOG = "Initial Release"

HOMEPAGE = https://github.com/destroyedlolo/TeleInfod
LICENSE  = Creative Commons Attribution-NonCommercial 3.0 License

WIZARDS_DIR = src/wizard/

INSTALLER_SCRIPT = src/installer.sh
SSS_SCRIPT       = src/dsm-control.sh

INSTALL_PREFIX = /usr/local/$(SPK_NAME)

POST_STRIP_TARGET = teleinfo2mqtt_extra_install

BUSYBOX_CONFIG = usrmng daemon nice
ENV += BUSYBOX_CONFIG="$(BUSYBOX_CONFIG)"

include ../../mk/spksrc.spk.mk


.PHONY: teleinfo2mqtt_extra_install
teleinfo2mqtt_extra_install:
	install -m 755 -d $(STAGING_DIR)/conf
	install -m 755 -d $(STAGING_DIR)/var
	install -m 644 src/conf/TeleInfo2Mqtt.conf $(STAGING_DIR)/conf/TeleInfo2Mqtt.conf
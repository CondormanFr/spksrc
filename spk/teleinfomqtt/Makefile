SPK_NAME = teleinfomqtt
SPK_VERS = 1.00
SPK_REV = 1
SPK_ICON = src/teleinfomqtt.png
DSM_UI_DIR = app

DEPENDS = cross/$(SPK_NAME)

MAINTAINER = SynoCommunity
DESCRIPTION = Test de Romain
DESCRIPTION_FRE =Programme qui écoute le signal TELEINFO sur le port serie et qui envoie les trame sur un broker MQTT.
RELOAD_UI = no
DISPLAY_NAME = TeleinfoMQTT
CHANGELOG = "Initial Release"

HOMEPAGE = https://github.com/destroyedlolo/TeleInfod
LICENSE  = none

WIZARDS_DIR = src/wizard/

INSTALLER_SCRIPT = src/installer.sh
SSS_SCRIPT       = src/dsm-control.sh

INSTALL_PREFIX = /usr/local/$(SPK_NAME)

POST_STRIP_TARGET = teleinfomqtt_extra_install

include ../../mk/spksrc.spk.mk


.PHONY: teleinfomqtt_extra_install
teleinfomqtt_extra_install:
	install -m 644 src/conf/TeleInfod.conf $(STAGING_DIR)/bin/TeleInfod.conf
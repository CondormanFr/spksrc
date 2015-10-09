SPK_NAME = teleinfomqtt
SPK_VERS = 1.00
SPK_REV = 1
SPK_ICON = src/teleinfomqtt.png
DSM_UI_DIR = app

DEPENDS = cross/$(SPK_NAME)

MAINTAINER = SynoCommunity
DESCRIPTION = 
DESCRIPTION_FRE =Programme qui écoute le signal TELEINFO sur le port serie et qui envoie les trame sur un broker MQTT.
RELOAD_UI = yes
DISPLAY_NAME = TeleinfoMQTT
CHANGELOG = "Initial Release"

HOMEPAGE = https://github.com/destroyedlolo/TeleInfod
LICENSE  =

WIZARDS_DIR = src/wizard/

INSTALLER_SCRIPT = src/installer.sh
SSS_SCRIPT       = src/dsm-control.sh

INSTALL_PREFIX = /usr/local/$(SPK_NAME)

include ../../mk/spksrc.spk.mk


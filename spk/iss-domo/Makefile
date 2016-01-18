SPK_NAME = iss-domo
SPK_VERS = 3.2.0
SPK_REV = 1
SPK_ICON = src/iss-domo.png
DSM_UI_DIR = app

DEPENDS  = cross/busybox

MAINTAINER = SynoCommunity
DESCRIPTION = iss-domo is a mapping between domoticz and imperihome 
ADMIN_URL = /iss-domo/
RELOAD_UI = yes
STARTABLE = yes
DISPLAY_NAME = iss-domo
CHANGELOG = "1. Update iss-domo to 3.2.0"
BETA = 1

HOMEPAGE   = https://github.com/bobinou/iss-domo
LICENSE    = MIT license

WIZARDS_DIR = src/wizard/

INSTALLER_SCRIPT = src/installer.sh
SSS_SCRIPT       = src/dsm-control.sh
FWPORTS          = src/${SPK_NAME}.sc

INSTALL_DEP_SERVICES = apache-web
START_DEP_SERVICES = apache-web
INSTUNINST_RESTART_SERVICES = apache-web

INSTALL_PREFIX = /usr/local/$(SPK_NAME)

POST_STRIP_TARGET = iss-domo_extra_install

BUSYBOX_CONFIG = usrmng daemon nice
ENV += BUSYBOX_CONFIG="$(BUSYBOX_CONFIG)"

include ../../mk/spksrc.spk.mk

.PHONY: iss-domo_extra_install
iss-domo_extra_install:
	install -m 755 -d $(STAGING_DIR)/var
	install -m 644 src/.rtorrent.rc $(STAGING_DIR)/var/
	install -m 755 -d $(STAGING_DIR)/var/.session
	install -m 755 -d $(STAGING_DIR)/etc
	install -m 644 src/cacert.pem $(STAGING_DIR)/etc/
	install -m 775 -d $(STAGING_DIR)/tmp
	install -m 755 -d $(STAGING_DIR)/app
	install -m 644 src/app/config $(STAGING_DIR)/app/config
	install -m 755 -d $(STAGING_DIR)/app/images
	for size in 16 24 32 48 72; do \
		convert $(SPK_ICON) -thumbnail $${size}x$${size} \
		        $(STAGING_DIR)/app/images/$(SPK_NAME)-$${size}.png ; \
	done

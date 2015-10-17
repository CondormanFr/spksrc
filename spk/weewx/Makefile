SPK_NAME = weewx
SPK_VERS = 3.2.1
SPK_REV = 2
SPK_ICON = src/weewx.png
DSM_UI_DIR = app

DEPENDS = cross/busybox cross/libjpeg  cross/freetype cross/zlib 

WHEELS = src/requirements.txt

SPK_DEPENDS = "python>=2.7.6-8"

MAINTAINER = SynoCommunity
DESCRIPTION = WeeWX
DESCRIPTION_FRE = WeeWX
DESCRIPTION_SPN = WeeWX
	RELOAD_UI = yes
DISPLAY_NAME = WeeWX
CHANGELOG = "WeeWX intial release"

HOMEPAGE   = http://www.weewx.com/support.html
LICENSE    = GPLV3

WIZARDS_DIR = src/wizard/

INSTALLER_SCRIPT = src/installer.sh
SSS_SCRIPT       = src/dsm-control.sh

INSTALL_PREFIX = /usr/local/$(SPK_NAME)


POST_STRIP_TARGET = weewx_extra_install


BUSYBOX_CONFIG  = nice
# Add ionice for ARCHs that support it
ifeq ($(findstring $(ARCH),88f6281 qoriq),$(ARCH))
BUSYBOX_CONFIG += ionice
endif
ENV += BUSYBOX_CONFIG="$(BUSYBOX_CONFIG)"

include ../../mk/spksrc.spk.mk

.PHONY: weewx_extra_install
weewx_extra_install: $(STAGING_DIR)/share/weewx
	install -m 755 -d ${STAGING_DIR}/share/wheelhouse
	install -m 644 ${WORK_DIR}/wheelhouse/* ${STAGING_DIR}/share/wheelhouse/
	install -m 755 -d $(STAGING_DIR)/var
	install -m 755 -d $(STAGING_DIR)/app
	install -m 644 src/app/config $(STAGING_DIR)/app/config
	install -m 755 -d $(STAGING_DIR)/app/images
	for size in 16 24 32 48 72; do \
		convert $(SPK_ICON) -thumbnail $${size}x$${size} \
		        $(STAGING_DIR)/app/images/$(SPK_NAME)-$${size}.png ; \
	done

$(STAGING_DIR)/share/weewx:
	install -m 755 -d $(STAGING_DIR)/share
	cd $(STAGING_DIR)/share && git clone --recursive https://github.com/weewx/weewx weewx
	rm -fr $(STAGING_DIR)/share/weewx/.git $(STAGING_DIR)/share/weewx/.gitignore
	install -m 655 src/config/setup.cfg $(STAGING_DIR)/share/weewx/setup.cfg
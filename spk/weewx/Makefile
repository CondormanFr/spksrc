SPK_NAME = weewx
SPK_VERS = 3.3.0b1
GIT_REV = 0c3687e
SPK_REV = 5
SPK_ICON = src/weewx.png


DEPENDS = cross/busybox

WHEELS = src/requirements.txt

SPK_DEPENDS = "python>=2.7.6-8"

MAINTAINER = SynoCommunity
DESCRIPTION = WeeWX is a free, open source, software program, written in Python, which interacts with your weather station to produce graphs, reports, and HTML pages. It can optionally publish to weather sites or web servers. It uses modern software concepts, making it simple, robust, and easy to extend.
DESCRIPTION_FRE = WeeWX est un logiciel gratuit, open source, écrit en Python, qui interagit avec votre station météo pour produire des graphiques, des rapports et des pages HTML. Il peut éventuellement publier sur des sites de météo ou des serveurs web. Il utilise des concepts logiciels modernes, le rendant simple, robuste et facile à étendre.
RELOAD_UI = yes
DISPLAY_NAME = WeeWX
CHANGELOG = "WeeWX intial release"

HOMEPAGE   = http://www.weewx.com
LICENSE    = GNU Public License v3

WIZARDS_DIR = src/wizard/

INSTALLER_SCRIPT = src/installer.sh
SSS_SCRIPT       = src/dsm-control.sh

INSTALL_PREFIX = /usr/local/$(SPK_NAME)


POST_STRIP_TARGET = weewx_extra_install


BUSYBOX_CONFIG  = nice daemon
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
	install -m 755 -d $(STAGING_DIR)/app/images
	for size in 16 24 32 48 72; do \
		convert $(SPK_ICON) -thumbnail $${size}x$${size} \
		        $(STAGING_DIR)/app/images/$(SPK_NAME)-$${size}.png ; \
	done

$(STAGING_DIR)/share/weewx:
	install -m 755 -d $(STAGING_DIR)/share
	cd $(STAGING_DIR)/share && git clone --recursive https://github.com/weewx/weewx weewx
	cd $(STAGING_DIR)/share/weewx && git checkout $(GIT_REV) && rm -rf .git && rm .gitignore
	install -m 655 src/config/setup.cfg $(STAGING_DIR)/share/weewx/setup.cfg
	install -m 755 -d $(STAGING_DIR)/extension
	cd $(STAGING_DIR)/extension
	wget -nv -c -O $(STAGING_DIR)/extension/weewx-mqtt-0.9.tgz http://lancet.mit.edu/mwall/projects/weather/releases/weewx-mqtt-0.9.tgz

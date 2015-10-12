PKG_NAME = teleinfomqtt
PKG_EXT = tar.gz
PKG_DOWNLOAD_METHOD = git
PKG_GIT_HASH = 92f007c
PKG_DIST_SITE = https://github.com/destroyedlolo/TeleInfod.git
PKG_DIST_FILE = $(PKG_NAME)-git$(PKG_GIT_HASH).$(PKG_EXT)
PKG_DIR = $(PKG_NAME)-git$(PKG_GIT_HASH)

DEPENDS = cross/mosquitto

HOMEPAGE = 
COMMENT  = 
LICENSE  = AGPLv3

CONFIGURE_TARGET = nop
COMPILE_TARGET = myCompile
INSTALL_TARGET = myInstall

include ../../mk/spksrc.cross-cc.mk

.PHONY: myCompile
myCompile:
	$(RUN) $(TC_PATH)$(TC_PREFIX)gcc -I$(STAGING_INSTALL_PREFIX)/include \
          -std=c99 -DUSE_MOSQUITTO -Wall TeleInfod.c -o TeleinfoMqtt \
          -L$(STAGING_INSTALL_PREFIX)/lib -Wl,--rpath-link,$(STAGING_INSTALL_PREFIX)/lib \
          -Wl,--rpath,/usr/local/$(PKG_NAME)/lib -lpthread -lmosquitto
	$(RUN) $(TC_PATH)$(TC_PREFIX)gcc -I$(STAGING_INSTALL_PREFIX)/include \
           -Wall SimuleTrames.c -o SimuleTrames \
          -L$(STAGING_INSTALL_PREFIX)/lib -Wl,--rpath-link,$(STAGING_INSTALL_PREFIX)/lib \
          -Wl,--rpath,/usr/local/$(PKG_NAME)/lib

.PHONY: myInstall
myInstall:
	@$(RUN) cp $(WORK_DIR)/$(PKG_DIR)/TeleinfoMqtt $(STAGING_INSTALL_PREFIX)/bin
	@$(RUN) cp $(WORK_DIR)/$(PKG_DIR)/SimuleTrames $(STAGING_INSTALL_PREFIX)/bin
	@$(RUN) cp $(WORK_DIR)/$(PKG_DIR)/TeleInfod.conf $(STAGING_INSTALL_PREFIX)/bin/TeleinfoMqtt.conf

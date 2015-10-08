PKG_NAME = teleinfomqtt
PKG_EXT = tar.gz
PKG_DOWNLOAD_METHOD = git
PKG_GIT_HASH = 2ddbd06
PKG_DIST_SITE = https://github.com/destroyedlolo/TeleInfod.git
PKG_DIST_FILE = $(PKG_NAME)-git$(PKG_GIT_HASH).$(PKG_EXT)
PKG_DIR = $(PKG_NAME)-git$(PKG_GIT_HASH)

DEPENDS = cross/mosquitto

HOMEPAGE = 
COMMENT  = 
LICENSE  = AGPLv3

CONFIGURE_TARGET = nop
COMPILE_TARGET = myCompile
INSTALL_TARGET = nop

include ../../mk/spksrc.cross-cc.mk

.PHONY: myCompil
myCompil:
  $(RUN) $(MAKE) -std=c99 -DUSE_MOSQUITTO -lpthread -lmosquitto -Wall TeleInfod.c -o TeleInfod

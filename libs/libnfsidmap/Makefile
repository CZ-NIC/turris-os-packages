#
# Copyright (C) 2007 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
# $Id$

include $(TOPDIR)/rules.mk

PKG_NAME:=libnfsidmap
PKG_VERSION:=0.25
PKG_RELEASE:=0

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=http://www.citi.umich.edu/projects/nfsv4/linux/libnfsidmap/
PKG_MD5SUM:=2ac4893c92716add1a1447ae01df77ab

include $(INCLUDE_DIR)/package.mk

define Package/libnfsidmap
  SECTION:=libs
  CATEGORY:=Libraries
  TITLE:=libnfsidmap, for compiling mount.nfs4
  URL:=http://www.citi.umich.edu/projects/nfsv4
endef

define Package/libnfsidmap/description
  Library needed by nfs-utils
endef

TARGET_CFLAGS += -I$(PKG_BUILD_DIR)/lib

MAKE_FLAGS += \
        OPT="$(TARGET_CFLAGS)" \
        INSTALLSUID="install -m 4755" \
        DESTDIR="$(PKG_INSTALL_DIR)" \
        all

define Build/InstallDev
	$(MAKE) -C "$(PKG_BUILD_DIR)" INSTALLSUID="install -m 4755" DESTDIR="$(1)" install
	find "$(1)" -name '*.a' -delete
endef

define Package/libnfsidmap/install
	$(MAKE) -C "$(PKG_BUILD_DIR)" INSTALLSUID="install -m 4755" DESTDIR="$(1)" install
	find "$(1)" -name '*.a' -delete
	rm -rf "$(1)"/usr/include
	rm -rf "$(1)"/usr/man
	rm -rf "$(1)"/usr/lib/pkgconfig
endef

$(eval $(call BuildPackage,libnfsidmap))

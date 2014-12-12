#
# Copyright (C) 2006-2013 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk
include $(INCLUDE_DIR)/kernel.mk

PKG_NAME:=lirc
PKG_VERSION:=0.8.7
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.bz2
PKG_SOURCE_URL:=@SF/${PKG_NAME}
PKG_MD5SUM:=fb1dcddbc8ca3d03c7f3a2d40cf28b71

PKG_BUILD_PARALLEL:=1

include $(INCLUDE_DIR)/package.mk

define Package/lirc/Default
    SECTION:=utils
    CATEGORY:=Utilities
    URL:=http://lirc.org/
endef

define Package/lirc
    $(call Package/lirc/Default)
    TITLE:=LIRC - Linux Infrared Remote Control
    MENU:=1
endef

define Package/lirc/description
 LIRC is a package that allows you to decode and send infra-red signals of many
 (but not all) commonly used remote controls.
endef

define Package/lircdaemonadd
    $(call Package/lirc/Default)
    DEPENDS:=lirc
    TITLE:=daemon additional files
endef

define Package/lircdaemonadd/description
 Contains additional daemon-tools.
endef

define  Package/lirctools
    $(call Package/lirc/Default)
    DEPENDS:=lirc
    TITLE:=LIRC tools
endef

define Package/lirctools/description
 Contains additional lirc-tools.
endef

CONFIGURE_ARGS += \
	--enable-sandboxed \
	--with-driver="mceusb" \
	--with-gnu-ld \
	--with-kerneldir="$(LINUX_DIR)" \
	--with-pic \
	--without-x \
	--disable-nls \
	--disable-static

define Package/lirc/conffiles
/etc/lircd.conf
endef

MAKE_FLAGS += \
	DESTDIR="$(PKG_INSTALL_DIR)" \
	SUBDIRS="daemons tools"

define Package/lirc/install
	$(INSTALL_DIR) $(1)/usr/sbin/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/daemons/lircd $(1)/usr/sbin/
	$(INSTALL_DIR) $(1)/etc
	$(INSTALL_CONF) $(PKG_BUILD_DIR)/contrib/lircd.conf $(1)/etc/
endef
#todo:
#	$(CP) $(PKG_BUILD_DIR)/drivers/lirc_dev/lirc_dev.ko
#	$(CP) $(PKG_BUILD_DIR)/drivers/lirc_mceusb2/lirc_mceusb2.ko
#depends on the selected module

define Package/lircdaemonadd/install
	$(INSTALL_DIR) $(1)/usr/sbin/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/daemons/irrecord $(1)/usr/sbin/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/daemons/lircmd $(1)/usr/sbin/
endef

define Package/lirctools/install
	$(INSTALL_DIR) $(1)/usr/sbin/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/tools/irsend $(1)/usr/sbin/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/tools/irw $(1)/usr/sbin/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/tools/mode2 $(1)/usr/sbin/
endef

$(eval $(call BuildPackage,lirc))
$(eval $(call BuildPackage,lircdaemonadd))
$(eval $(call BuildPackage,lirctools))

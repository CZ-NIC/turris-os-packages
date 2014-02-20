#
# Copyright (C) 2010-2013 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=fowsr
PKG_VERSION:=2.0-131015
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=http://fowsr.googlecode.com/svn/tags/Releases/
PKG_MD5SUM:=7f78e8d2b1a162a99e684cab49a210a0

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME).src

include $(INCLUDE_DIR)/package.mk

define Package/fowsr
  SECTION:=utils
  CATEGORY:=Utilities
  DEPENDS:=+libusb-compat
  TITLE:=Fine Offset Wireless Weather Station Reader
  URL:=http://fowsr.googlecode.com/
endef

define Package/fowsr/description
  fowsr is a USB Data Collector application for WH1080 compatible
  weather stations.
  Output formats include XML, Wunderground.com and pywws.
endef

define Package/fowsr/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/fowsr $(1)/usr/bin/
	$(INSTALL_BIN) \
		$(PKG_BUILD_DIR)/{fowsr,pwsweather,pywws,wunderground,xml}.sh \
		$(1)/usr/bin/
endef

$(eval $(call BuildPackage,fowsr))

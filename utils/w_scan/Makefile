#
# Copyright (C) 2006-2012 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=w_scan
PKG_VERSION:=20170107
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.bz2
PKG_SOURCE_URL:=http://wirbel.htpc-forum.de/w_scan/
PKG_MD5SUM:=c7f9adf92d46b8da5391be80be6fbd72

PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/autotools.mk
include $(INCLUDE_DIR)/nls.mk

define Package/w_scan
  SECTION:=utils
  CATEGORY:=Utilities
  DEPENDS:=+libiconv-full +librt
  TITLE:=Performd frequency scans for DVB and ATSC transmissions
  URL:=https://www.linuxtv.org/wiki/index.php/W_scan
endef

define Package/w_scan/description
	w_scan is a small command line utility used to perform frequency scans for
	DVB and ATSC transmissions. It is not included in LinuxTV dvb-apps, but
	complements the two frequency scanning utilities available through LinuxTV
	dvb-apps, dvbscan and scan.

	w_scan is capable of directly creating channels.conf files as well as initial
	tuning data for scan. 
endef


CONFIGURE_ARGS+= \
	--with-libiconv="$(ICONV_PREFIX)"

TARGET_CFLAGS+="-I$(STAGING_DIR)/usr/lib/libintl-full/include"
TARGET_CPPFLAGS+="-I$(STAGING_DIR)/usr/lib/libintl-full/include"
TARGET_LDFLAGS+="-L$(STAGING_DIR)/usr/lib/libintl-full/lib -liconv"

define Build/Configure
	$(call Build/Configure/Default)
	$(call Build/Compile/Default, version)
endef

define Package/w_scan/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(CP) $(PKG_INSTALL_DIR)/usr/bin/w_scan $(1)/usr/bin/
endef

$(eval $(call BuildPackage,w_scan))

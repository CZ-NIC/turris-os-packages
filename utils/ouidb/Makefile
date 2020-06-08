#
## Copyright (C) 2013-2020 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=ouidb
PKG_VERSION:=20200531

PKG_SOURCE_VERSION:=5e0ebc9fc05b1f0ad557136e748adc9088bfdca4
PKG_SOURCE_URL:=https://github.com/wireshark/wireshark/raw/$(PKG_SOURCE_VERSION)
PKG_SOURCE_URL_FILE:=manuf
PKG_SOURCE:=$(PKG_NAME)-$(PKG_SOURCE_VERSION).txt
PKG_HASH:=3241416dcc37c9778a0bab500fd1154e89996d51105a982bb9c02c6714303c8d

UNPACK_CMD:=:

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>

include $(INCLUDE_DIR)/package.mk

define Package/ouidb
  SECTION:=utils
  CATEGORY:=Utilities
  TITLE:=OUI database
endef

define Build/Compile
	awk -v re='^[0-9A-F]{2}:[0-9A-F]{2}:[0-9A-F]{2}$$$$' \
		'$$$$1 ~ re && $$$$3 { gsub(":", "", $$$$1); print $$$$1 "|" $$$$3 }' \
		$(DL_DIR)/$(PKG_SOURCE) > $(PKG_BUILD_DIR)/oui.db
endef

define Package/ouidb/install
	$(INSTALL_DIR) $(1)/usr/bin/ $(1)/usr/share/ouidb/
	$(INSTALL_BIN) ./files/ouidb $(1)/usr/bin/
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/oui.db $(1)/usr/share/ouidb/
endef

$(eval $(call BuildPackage,ouidb))

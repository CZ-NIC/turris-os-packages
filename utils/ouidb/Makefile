#
## Copyright (C) 2013-2020, 2022 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=ouidb
PKG_VERSION:=20220320
PKG_RELEASE:=1

PKG_SOURCE_VERSION:=6a97b2095c4c2a31b2099037a43814990c611648
PKG_SOURCE_URL:=https://github.com/wireshark/wireshark/raw/$(PKG_SOURCE_VERSION)
PKG_SOURCE_URL_FILE:=manuf
PKG_SOURCE:=$(PKG_NAME)-$(PKG_SOURCE_VERSION).txt
PKG_HASH:=0737d8aaaa404f3d0606e34b4622c840535885fc899aecb2964a4b96f2db51d6

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

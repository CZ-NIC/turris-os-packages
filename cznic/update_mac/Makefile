#
## Copyright (C) 2013 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=update_mac
PKG_VERSION:=1
PKG_SOURCE_SUBDIR:=$(PKG_NAME)
PKG_MAINTAINER:=Martin Strbacka <martin.strbacka@nic.cz>
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
	TITLE:=$(PKG_NAME)
	DEPENDS:=+libatsha204
endef

define Build/Compile
	echo Building OK
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/etc/init.d

	$(INSTALL_BIN) ./files/etc/init.d/update_mac $(1)/etc/init.d/update_mac
endef

$(eval $(call BuildPackage,$(PKG_NAME)))

#
## Copyright (C) 2013-2020 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=nor-update
PKG_VERSION:=6
PKG_RELEASE:=1

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>

include $(INCLUDE_DIR)/package.mk

define Package/nor-update
  TITLE:=NOR update for Turris 1.x
  DEPENDS:=@TARGET_mpc85xx_p2020_DEVICE_turris1x +mtd
endef

Build/Compile:=:

define Package/nor-update/install
	$(INSTALL_DIR) $(1)/usr/share/nor-update/turris
	$(INSTALL_DATA) ./files/mtd* $(1)/usr/share/nor-update/turris
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/init $(1)/etc/init.d/nor-update
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_BIN) ./files/nor-update $(1)/usr/sbin/nor-update
	sed -i "s|@VERSION@|${PKG_VERSION}|" $(1)/usr/sbin/nor-update
endef

define Package/nor-update/postinst
#!/bin/sh
if [ -z "$${IPKG_INSTROOT}" ] ; then
	/etc/init.d/nor-update enable
fi
endef

$(eval $(call BuildPackage,nor-update))

#
## Copyright (C) 2016-2020 CZ.NIC z.s.p.o. (https://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=netmetr
PKG_VERSION:=2.0.2
PKG_RELEASE:=$(AUTORELEASE)

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.nic.cz/turris/netmetr-client.git
PKG_MIRROR_HASH:=f70491317015299b5c61015062421f2ddf35de67e1b5cc23aa4a6db679a5a089
PKG_SOURCE_VERSION:=v$(PKG_VERSION)
PKG_SOURCE:=netmetr-client-v$(PKG_SOURCE_VERSION).tar.gz

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>
PKG_LICENSE:=GPL-3.0-or-later

include $(INCLUDE_DIR)/package.mk
include $(TOPDIR)/feeds/packages/lang/python/python3-package.mk

define Package/netmetr
  SECTION:=net
  CATEGORY:=Network
  TITLE:=Speed measurement application
  URL:=https://gitlab.nic.cz/turris/netmetr-client
  DEPENDS:= \
  +python3-light \
  +python3-setuptools \
  +python3-pyserial \
  +rmbt-client \
  +cronie \
  +xz
endef

define Package/netmetr/description
  Python wrapper for RMBT C application that
  provides download and upload speed measurements.
endef

define Py3Package/netmetr/install
	$(INSTALL_DIR) $(1)
	$(CP) $(PKG_INSTALL_DIR)/* $(1)/

	$(INSTALL_DIR)  $(1)/etc/config
	$(INSTALL_CONF)	./files/netmetr.config		$(1)/etc/config/netmetr

	$(INSTALL_DIR)  $(1)/etc/cron.d
	$(INSTALL_DATA) ./files/netmetr.cron 		$(1)/etc/cron.d/netmetr
endef

define Package/netmetr/conffiles
/etc/config/netmetr
endef

$(eval $(call Py3Package,netmetr))
$(eval $(call BuildPackage,netmetr))
$(eval $(call BuildPackage,netmetr-src))

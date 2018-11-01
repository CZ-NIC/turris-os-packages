#
## Copyright (C) 2016-2017 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
## This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
# #
#
include $(TOPDIR)/rules.mk

PKG_NAME:=netmetr
PKG_VERSION:=1.4
PKG_RELEASE:=2

PKG_MAINTAINER:=CZ.NIC <packaging@turris.cz>

PKG_SOURCE:=netmetr-client-v$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://gitlab.labs.nic.cz/turris/netmetr-client/-/archive/v$(PKG_VERSION)/
PKG_HASH:=766f8e6d5b343739acdcbda12fc77c1d094480ada27e2a6456173f8ea2f501fd

PKG_LICENSE:=GPLv3

PKG_BUILD_DIR:=$(BUILD_DIR)/$(BUILD_VARIANT)-netmetr-client-v$(PKG_VERSION)

PKG_BUILD_DEPENDS:=python3 python3-setuptools

include $(INCLUDE_DIR)/package.mk
include $(TOPDIR)/feeds/packages/lang/python/python3-package.mk

PKG_UNPACK:=$(HOST_TAR) -C $(PKG_BUILD_DIR) --strip-components=1 -xzf $(DL_DIR)/$(PKG_SOURCE)

define Package/$(PKG_NAME)
	TITLE:=Speed measurement application
	URL:=https://gitlab.labs.nic.cz/turris/netmetr-client
	MAINTAINER:=CZ.NIC <packaging@turris.cz>
	DEPENDS:=+rmbt-client +vixie-cron +python3-light +python3-pyserial +xz
	VARIANT:=python3
endef

define Package/$(PKG_NAME)/description
  Python wrapper for RMBT C application that
  provides download and upload
  speed measurements.
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)
	$(CP) $(PKG_INSTALL_DIR)/* $(1)/

	$(INSTALL_DIR)  $(1)/etc/config
	$(INSTALL_CONF)	./files/netmetr.config		$(1)/etc/config/netmetr

	$(INSTALL_DIR)  $(1)/etc/cron.d
	$(INSTALL_DATA) ./files/netmetr.cron 		$(1)/etc/cron.d/netmetr
endef

define Package/$(PKG_NAME)/conffiles
/etc/config/netmetr
endef

$(eval $(call Py3Package,netmetr))
$(eval $(call BuildPackage,netmetr))

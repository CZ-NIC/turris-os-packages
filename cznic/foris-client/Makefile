#
# Copyright (C) 2018 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=foris-client
PKG_VERSION:=0.8
PKG_RELEASE:=1
PKG_SOURCE_SUBDIR:=$(PKG_NAME)
PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.labs.nic.cz/turris/foris-client
PKG_SOURCE_VERSION:=v$(PKG_VERSION)
PKG_SOURCE:=$(PKG_NAME)-$(PKG_SOURCE_VERSION).tar.gz
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)
PKG_LICENSE:=GPL-3.0

include $(INCLUDE_DIR)/package.mk
$(call include_mk, python-package.mk)
$(call include_mk, python3-package.mk)


define Package/Common
	URL:=https://pythonhosted.org/python-prctl/
	MAINTAINER:=CZ.NIC <packaging@turris.cz>
endef


define Package/foris-client
	$(call Package/Common)
	TITLE:=foris-client
	DEPENDS:=+foris-controller +foris-client-python2 +foris-client-python3 +foris-client-bin
endef

define Package/foris-client/description
	An program/library which is act as a client of foris-controller.
endef

define Package/foris-client-python2
	$(call Package/Common)
	TITLE:=foris-client-python2
	DEPENDS:=+python-light +python-ubus +python-setuptools
endef

define Package/foris-client-python3
	$(call Package/Common)
	TITLE:=foris-client-python3
	DEPENDS:=+python3-light +python3-ubus +python3-setuptools
endef

define Package/foris-client-bin
	$(call Package/Common)
	TITLE:=foris-client-bin
	DEPENDS:=+foris-client-python3
endef

define Build/Compile
	$(call Build/Compile/PyMod,., \
		install --prefix="/usr" --root="$(PKG_INSTALL_DIR)/py2" \
	)
	$(call Build/Compile/Py3Mod,., \
		install --prefix="/usr" --root="$(PKG_INSTALL_DIR)/py3" \
	)
endef

define Package/foris-client/conffiles
endef

define Package/foris-client-python2/install
	$(INSTALL_DIR) $(1)
	$(CP) $(PKG_INSTALL_DIR)/py2/* $(1)/
	$(RM) $(1)/usr/bin/*
endef

define Package/foris-client-python3/install
	$(INSTALL_DIR) $(1)
	$(CP) $(PKG_INSTALL_DIR)/py3/* $(1)/
	$(RM) $(1)/usr/bin/*
endef

define Package/foris-client-bin/install
	$(INSTALL_DIR) $(1)/usr/bin/
	$(CP) $(PKG_INSTALL_DIR)/py3/usr/bin/foris-* $(1)/usr/bin/
	$(INSTALL_BIN) ./files/foris-client-wrapper $(1)/usr/bin/foris-client-wrapper
	$(INSTALL_BIN) ./files/foris-notify-wrapper $(1)/usr/bin/foris-notify-wrapper
endef

$(eval $(call BuildPackage,foris-client-python3))
$(eval $(call BuildPackage,foris-client-python2))
$(eval $(call BuildPackage,foris-client-bin))
$(eval $(call BuildPackage,foris-client))

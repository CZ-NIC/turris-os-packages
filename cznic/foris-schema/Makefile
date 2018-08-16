#
# Copyright (C) 2018 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=foris-schema
PKG_VERSION:=0.7.1
PKG_RELEASE:=1
PKG_SOURCE_SUBDIR:=$(PKG_NAME)
PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.labs.nic.cz/turris/foris-schema
PKG_SOURCE_VERSION:=v$(PKG_VERSION)
PKG_SOURCE:=$(PKG_NAME)-$(PKG_SOURCE_VERSION).tar.gz
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)
PKG_LICENSE:=GPL-3.0

include $(INCLUDE_DIR)/package.mk
$(call include_mk, python-package.mk)
$(call include_mk, python3-package.mk)

define Package/Common
	MAINTAINER:=CZ.NIC <packaging@turris.cz>
	URL:=https://gitlab.labs.nic.cz/turris/foris-schema
endef

define Package/foris-schema
	$(call Package/Common)
	TITLE:=foris-schema
	DEPENDS:=+python-jsonschema
endef

define Package/foris-schema-python3
	$(call Package/Common)
	TITLE:=foris-schema-python3
	DEPENDS:=+python3-jsonschema
endef

define Package/foris-schema/description
	Library which validates whether the json matches
	the protocol use between Foris web and a configuration backend.
endef

define Build/Compile
	$(call Build/Compile/PyMod,., \
		install --prefix="/usr" --root="$(PKG_INSTALL_DIR)/py2" \
	)
	$(call Build/Compile/Py3Mod,., \
		install --prefix="/usr" --root="$(PKG_INSTALL_DIR)/py3" \
	)
endef

define Package/foris-schema/conffiles
endef

PKG_INSTALL_DIR_ORIG:="$(PKG_INSTALL_DIR)"
PKG_INSTALL_DIR:="$(PKG_INSTALL_DIR_ORIG)/py2"
$(eval $(call PyPackage,foris-schema))
PKG_INSTALL_DIR:="$(PKG_INSTALL_DIR_ORIG)/py3"
$(eval $(call Py3Package,foris-schema-python3))
PKG_INSTALL_DIR:="$(PKG_INSTALL_DIR_ORIG)"


$(eval $(call BuildPackage,foris-schema))
$(eval $(call BuildPackage,foris-schema-python3))

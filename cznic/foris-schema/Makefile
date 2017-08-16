#
# Copyright (C) 2017 CZ.NIC z.s.p.o. (http://www.nic.cz/)
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=foris-schema
PKG_VERSION:=0.1
PKG_RELEASE:=1
PKG_SOURCE_SUBDIR:=$(PKG_NAME)
PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://gitlab.labs.nic.cz/turris/foris-schema
PKG_SOURCE_VERSION:=v$(PKG_VERSION)
PKG_SOURCE:=$(PKG_NAME)-$(PKG_SOURCE_VERSION).tar.gz
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)
PKG_LICENSE:=GPL-3.0

PKG_BUILD_DEPENDS:=python-jsonschema/host

include $(INCLUDE_DIR)/package.mk
$(call include_mk, python-package.mk)


define Package/foris-schema
	TITLE:=foris-schema
	URL:=https://gitlab.labs.nic.cz/turris/foris-schema
	DEPENDS:=+python-jsonschema
	MAINTAINER:=Stepan Henek <stepan.henek@nic.cz>
endef

define Package/foris-schema/description
	Library which validates whether the json matches
	the protocol use between Foris web and a configuration backend.
endef

define Build/Compile
	$(call Build/Compile/PyMod,,install --prefix=/usr --root=$(PKG_INSTALL_DIR))
endef

define Package/foris-schema/conffiles
endef

define Package/foris-schema/install
	$(INSTALL_DIR) $(1)$(PYTHON_PKG_DIR)/
	$(CP) \
		$(PKG_INSTALL_DIR)$(PYTHON_PKG_DIR)/* \
		$(1)$(PYTHON_PKG_DIR)/
endef


$(eval $(call BuildPackage,foris-schema))

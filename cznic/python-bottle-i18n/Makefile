#
# Copyright (C) 2013 CZ.NIC z.s.p.o. <jan.cermak@nic.cz>
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=bottle-i18n
PKG_VERSION:=0.1.1
PKG_RELEASE:=1
PKG_SOURCE_SUBDIR:=$(PKG_NAME)
PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/iocast/bottle-i18n.git
PKG_SOURCE_VERSION:=2f69e1deea985f4f9d631c5085a36fb8ca95aeab
PKG_SOURCE:=$(PKG_NAME)-$(PKG_SOURCE_VERSION).tar.gz
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk
$(call include_mk, python-package.mk)

define Package/python-bottle-i18n
	SUBMENU:=Python
	SECTION:=lang
	CATEGORY:=Languages
	TITLE:=python-bottle-i18n
	URL:=https://github.com/iocast/bottle-i18n
	DEPENDS:=+python +python-bottle
	MAINTAINER:=Jan Cermak <jan.cermak@nic.cz>
endef

define Package/python-bottle-i18n/description
	i18n support for bottle.py
endef

define Build/Compile
	$(call Build/Compile/PyMod,,install --prefix=/usr --root=$(PKG_INSTALL_DIR))
endef

define Package/python-bottle-i18n/install
	$(INSTALL_DIR) $(1)$(PYTHON_PKG_DIR)/
	$(CP) \
		$(PKG_INSTALL_DIR)$(PYTHON_PKG_DIR)/* \
		$(1)$(PYTHON_PKG_DIR)/
endef

$(eval $(call BuildPackage,python-bottle-i18n))
